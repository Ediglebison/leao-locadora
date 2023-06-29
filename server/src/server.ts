import fastify from 'fastify'
import { PrismaClient } from '@prisma/client'

const app = fastify()
const prisma = new PrismaClient()

app.post('/home', async() => {
  const usuarios = await prisma.usuario.findMany()
  return usuarios
})

app
  .listen({
    port: 3333,
  })
  .then(() => {
    console.log('http://localhost:3333')
  })
