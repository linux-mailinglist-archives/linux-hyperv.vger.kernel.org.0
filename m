Return-Path: <linux-hyperv+bounces-1325-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F9280F56E
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 19:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A682281DC6
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Dec 2023 18:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D647E795;
	Tue, 12 Dec 2023 18:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MnctoqFy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2111.outbound.protection.outlook.com [40.107.117.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF1EA1;
	Tue, 12 Dec 2023 10:22:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtZtXeX269TLZkbCuuHtj5/J4PULGkvXz5FCJ9CYKH7W1Lztn+KzB2F2erq1tFPf3NYWs72lBiJagCgtXAUdmkfTOPb1RPFl4HymjpOMmFQvCX2hJ9IJpAfkimnXH1Lnhz9WpOKwXxJFOvSEErTAUUJfHxK/gbFvE0WkhOjE87k38CMrmXrKaNgrohu1D11qkGJ4QmMy6FaBBU0eF4I7ojgSv3ReS3hht2Xx+kY/I0/aNUogeB+sz2GisS3gTkIPzRdWzGhwxYM+V1rNkujYMRZd+vxOUGeq+ucXzpbUpsV72z6pJsEATfRW1DZ5JTnwt4mSZoVQWVyu7EyltDG3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BxUx1HluOJ1/JD4jMatsO463WdOL/Csu/VPd3pfx0w=;
 b=faj5Bu3f5qjUt8yAnJ8/zOCh3aou6I7dv1P8pK6OPhzSL7cq1qEWOtjH1mbYgJTBIcMeeDqMwUdeH0yVZ9shr5Rn1fSppasQLQK/Cx8fZpHaB93j6FsbPMH4rqrMucGLyGXEuwbr+1ODXuRofryLT239nLAml58+5A4Rpcn9GlNWqqsy/b1h/ur5HO/Y8230jlOH+zo/kOD5q8Hg3qU+acf8wwVIVFjfCrA+hGnHZuxt55/RpA18sQI2GKevU+7rTQpzijMWznrBx3dYhf8EzDSsT7wUThqxQ0018kx8PW6+X5EBB7Spf/nrCALcujbxdKUy92RHKbEPebqSS58Nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BxUx1HluOJ1/JD4jMatsO463WdOL/Csu/VPd3pfx0w=;
 b=MnctoqFyvaIFBqOp+rv7zgt0nnUJ9P8elo4/+jFH1SUeSh313V7Buv4CI9c8gLGHusYUpELDMQQ9QENLP8agePHqWJAlCCMPlRoYN033NAnPoL5b/S9CnRlQWxC9bgAJ25hLl3o5yuIs4Z/wwbJUXOSjY0fgp4n/qBZoU6dd6P4=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by JH0P153MB0998.APCP153.PROD.OUTLOOK.COM (2603:1096:990:65::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.7; Tue, 12 Dec
 2023 18:22:22 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a%7]) with mapi id 15.20.7113.001; Tue, 12 Dec 2023
 18:22:21 +0000
From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
To: Suman Ghosh <sumang@marvell.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>, "yury.norov@gmail.com"
	<yury.norov@gmail.com>, "leon@kernel.org" <leon@kernel.org>,
	"cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXT] [PATCH V5 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Thread-Topic: [EXT] [PATCH V5 net-next] net: mana: Assigning IRQ affinity on
 HT cores
Thread-Index: AQHaKb2yyLqfMUcaOkaTPv6Y9y+C5bCl+3qAgAAAzfA=
Date: Tue, 12 Dec 2023 18:22:20 +0000
Message-ID:
 <PUZP153MB0788323DA797C8DED27E2172CC8EA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References:
 <1702029754-6520-1-git-send-email-schakrabarti@linux.microsoft.com>
 <SJ0PR18MB5216C6E41006057839D3C01BDB8EA@SJ0PR18MB5216.namprd18.prod.outlook.com>
In-Reply-To:
 <SJ0PR18MB5216C6E41006057839D3C01BDB8EA@SJ0PR18MB5216.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=778aa93c-52b4-475e-889f-59b496a4865d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-12T18:20:27Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|JH0P153MB0998:EE_
x-ms-office365-filtering-correlation-id: ad0701a3-7774-4a72-04c0-08dbfb3f47a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ixxiC0SjOmVhZUplTdgOHnljqtojsKqGULfN/LG1ykgKyU7Y6IRI6PhSQ6bqvbcHZllpYC9E7NS1vomlVNNNehcTjSSEkhZVjr1DF8eSgNaQiUJ9ufA3iSqHi1XEzYkkmZPC4gWxAQuTf+2v5xFkxtTxw219uEKD6/P4tkyIe5JZbTtRxdfonH4DueUiL7P5K6cGgMAp/A6qzkB0Z9dmvI6AhB2+MF4h9FMFSkfq0nBZOkgb3wC1Wsb8Ne9d5oL0fTXU1rBDoaFqOkj6aPTj5LtmIWk1Fbz75sBYfs1Qboktz0TEeVy7Mg6YDuEXcw1WugZCgAITryxTjfJUMkec0Kn7W4FwGLjxFZcqyacnV/l8VzayLVgOaOMz5DXuhBiCWfq+T2HtvRk6r6I2QoyfV9qHJdbuSWH27GEQKjYlNgdJXxPTOpkDHQolxzzbiTHtFTXud3bDb+TfG23kvby31mxWOOF2nOcjYENH7n4zSyzjOGgTRBLofWLkP/sBC3gtrGSnqNgqXwsRGScihBSQZXa2aQpqFh/hUZg6t397pBxaj9qJKH1oAc/ulano5aF9NJA9C+hVvg/lwf1FOGS7qhdbjF/chVo1gttEJRvegDywroEKHc2xpJzAnkziq8y3hNkH95PSuRlzpjEqmEdgMfBDatmbUJlfH0r4TpVisuD+ez/yhCtqRGc1CU9/2Zi523GZzyxCjmZphtIHEnkZ9jEzYc77Vjo/V1eD0KajiZ0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(110136005)(64756008)(66446008)(76116006)(66476007)(66946007)(66556008)(41300700001)(7696005)(6506007)(26005)(107886003)(71200400001)(921008)(38070700009)(86362001)(38100700002)(122000001)(82950400001)(33656002)(82960400001)(9686003)(83380400001)(8990500004)(10290500003)(478600001)(52536014)(8936002)(4326008)(8676002)(55016003)(2906002)(7416002)(5660300002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gtAMxoU8IANsa+2DnQicK5FuLTXJgT4Sp0ICs5e8z/dg0ZCoMszrNxjAyxqg?=
 =?us-ascii?Q?OiyBtslfSYeya1aEbHwQmbgFJEpyrL3uaQVlQoOA1RjJD34VXXQvlFHlqUvk?=
 =?us-ascii?Q?Lnd6Q0efvMolGea9R7F1iqeMsImV0kaz5sjn6iVgBQ5uaT6uSM6DPmo0uwEg?=
 =?us-ascii?Q?3BxGyg6ZTwP43eDw1WCtzY3symuGIUUuJsE53JOslNJduxcvo64MTUKTSIVb?=
 =?us-ascii?Q?BzULkK+lVCIuApJSD/4JB87cnvkl0KM9O8c0Eql5c011fNKEBc5Eo64VoH/2?=
 =?us-ascii?Q?McHl4FnnZkNMxVujeDFcUrCIBr5zNsoKh2uBGzaBNIiy/NM0HiDrKlwWjQFc?=
 =?us-ascii?Q?diScsZq4o3BIKApRD/Kw9z3zJNnYFIEUbhPjbUZAfnwJIQfdw7jRaoNQkyfu?=
 =?us-ascii?Q?Fht6tZFftZVKa2NTl5w6eLudlHutyCv+tUHKflA8i1Mz7451rZJXjypaWKTw?=
 =?us-ascii?Q?iiQOWR1+N5qtFJRx/Y53Z2MoLCgcNHtW5LOOYRr9jeuomnekHtZph1dMuJxx?=
 =?us-ascii?Q?llJ21N93d6g+WSrfs266iykVbmJmX2g20qPeDgbok28wS1QtiD3YWYqyVNxe?=
 =?us-ascii?Q?sxJKbVbs+KlVgnf6QVSyl6g5tbWvcPqAV5QAvkkraIaje/HxQmIdJT4D0u6y?=
 =?us-ascii?Q?ASQHtkiKegrTaQnwVcEEtWkY+QXJXHZkqBAMQLIGPral1QGUqjkStQ/gxmTM?=
 =?us-ascii?Q?WIwhvpBEBhLPH7YWpWquMA1ntcbc0ksTD9+9bPqvENKIGYCogvMCKQQ6hKzC?=
 =?us-ascii?Q?8mvmV7NbDQPp7lj7+gfDzBK6E+usMHvV52yoiOC4a8oG5uHF4bM5ceXWz4A7?=
 =?us-ascii?Q?Qyn4g79VWzlzCjnoRen+sY5N6+26+O9g+FtO4qb3T7XSR1PB1lnxOVM8J7KU?=
 =?us-ascii?Q?WznU0qAJA1e0+8fyTz447kKNNGbhsdHmWcMGcGCtfpmaxYLnUAG3ZjjUB8GF?=
 =?us-ascii?Q?bAaRp1uzZ5PKsTno/lyJTXlSnjTWVo1jwDub1f8Jj0+EbeAVAPCrautC/KFL?=
 =?us-ascii?Q?t/5mgfsf1yBwOqtJfCYoWH7xQS9gSiwrV/3WGBUTxMEr8YUpQ/ZpXj+U/MaS?=
 =?us-ascii?Q?6eZ5Gh0cBEXXBCvN/LFs1tbhiQLTmfAay0V5YXrTpspXUUH9bz768ccSjOu8?=
 =?us-ascii?Q?gUr4fMDD/uopG3iTXs9LgO9EKyj3aWlRbtz1ULLOIZL7GDUjPS4NIcg5FuKN?=
 =?us-ascii?Q?jFsbUTGWvprGfmZYHNLA0EFtAhZtn+cnt+YA2O8AzCTuq2X6DkjV31L3C7JN?=
 =?us-ascii?Q?oxf+5v0Pu4ybhSAAJZOsWYGlSZJplAUBAo/jdbzz3yE1YdrmZ2Z8ocj0kdxX?=
 =?us-ascii?Q?e3r0SVnPQ9V364Ix7ShHGpwrKMgDA7s7Ni3dqhubTnQfKkIQoWqufq4WXjqu?=
 =?us-ascii?Q?EgDCoYvUoKggR26XYXzy+bbNM00c2HSnKsNFfq5sFkxgLftuKpe0qk0GH8XL?=
 =?us-ascii?Q?h6CqNjPwbbi/6pk1YcR5odseCFG0xPtDNf3pzt4DNqVWFiA39J69FEGOBDH8?=
 =?us-ascii?Q?lR9CD08k6Q6H9MaJtUG6ju+3TMmcAtB1cufG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0701a3-7774-4a72-04c0-08dbfb3f47a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2023 18:22:20.6256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8PeVkznB5aNO0bzlTZnr/aYbX+T94LIcwBm/O6A3GmaJg9aPHS59r+3lOnKeYwu/0QaPr/sGXMpDt954VMnJ+1TKMGfpx0kWSy/Z2ci4Fj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0P153MB0998



>-----Original Message-----
>From: Suman Ghosh <sumang@marvell.com>
>Sent: Tuesday, December 12, 2023 11:48 PM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>; KY Srinivasa=
n
><kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>;
>wei.liu@kernel.org; Dexuan Cui <decui@microsoft.com>; davem@davemloft.net;
>edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Long Li
><longli@microsoft.com>; yury.norov@gmail.com; leon@kernel.org;
>cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com;
>tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; =
linux-
>kernel@vger.kernel.org; linux-rdma@vger.kernel.org
>Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Paul Rosswurm
><paulros@microsoft.com>
>Subject: [EXTERNAL] RE: [EXT] [PATCH V5 net-next] net: mana: Assigning IRQ
>affinity on HT cores
>
>[Some people who received this message don't often get email from
>sumang@marvell.com. Learn why this is important at
>https://aka.ms/LearnAboutSenderIdentification ]
>
>Hi Souradeep,
>
>Please find inline for couple of comments.
>
>>+
>>+      if (!zalloc_cpumask_var(&curr, GFP_KERNEL)) {
>>+              err =3D -ENOMEM;
>>+              return err;
>>+      }
>>+      if (!zalloc_cpumask_var(&cpus, GFP_KERNEL)) {
>[Suman] memory leak here, should free 'curr'.
This will be taken care in next version.
>>+              err =3D -ENOMEM;
>>+              return err;
>>+      }
>>+
>>+      rcu_read_lock();
>>+      for_each_numa_hop_mask(next, next_node) {
>>+              cpumask_andnot(curr, next, prev);
>>+              for (w =3D cpumask_weight(curr), cnt =3D 0; cnt < w; ) {
>>+                      cpumask_copy(cpus, curr);
>>+                      for_each_cpu(cpu, cpus) {
>>+                              irq_set_affinity_and_hint(irqs[i],
>>topology_sibling_cpumask(cpu));
>>+                              if (++i =3D=3D nvec)
>>+                                      goto done;
>>+                              cpumask_andnot(cpus, cpus,
>>topology_sibling_cpumask(cpu));
>>+                              ++cnt;
>>+                      }
>>+              }
>>+              prev =3D next;
>>+      }
>>+done:
>>+      rcu_read_unlock();
>>+      free_cpumask_var(curr);
>>+      free_cpumask_var(cpus);
>>+      return err;
>>+}
>>+
>> static int mana_gd_setup_irqs(struct pci_dev *pdev)  {
>>-      unsigned int max_queues_per_port =3D num_online_cpus();
>>       struct gdma_context *gc =3D pci_get_drvdata(pdev);
>>+      unsigned int max_queues_per_port;
>>       struct gdma_irq_context *gic;
>>       unsigned int max_irqs, cpu;
>>-      int nvec, irq;
>>+      int start_irq_index =3D 1;
>>+      int nvec, *irqs, irq;
>>       int err, i =3D 0, j;
>>
>>+      cpus_read_lock();
>>+      max_queues_per_port =3D num_online_cpus();
>>       if (max_queues_per_port > MANA_MAX_NUM_QUEUES)
>>               max_queues_per_port =3D MANA_MAX_NUM_QUEUES;
>>
>>@@ -1261,6 +1302,14 @@ static int mana_gd_setup_irqs(struct pci_dev
>>*pdev)
>>       nvec =3D pci_alloc_irq_vectors(pdev, 2, max_irqs, PCI_IRQ_MSIX);
>>       if (nvec < 0)
>[Suman] cpus_read_unlock()?
Thanks for pointing, it will be taken care off in the V6.
>>               return nvec;
>>+      if (nvec <=3D num_online_cpus())
>>+              start_irq_index =3D 0;
>>+
>>+      irqs =3D kmalloc_array((nvec - start_irq_index), sizeof(int),
>>GFP_KERNEL);
>>+      if (!irqs) {
>>+              err =3D -ENOMEM;
>>+              goto free_irq_vector;
>>+      }
>>
>>       gc->irq_contexts =3D kcalloc(nvec, sizeof(struct gdma_irq_context)=
,
>>                                  GFP_KERNEL); @@ -1287,21 +1336,44 @@
>>static int mana_gd_setup_irqs(struct pci_dev
>>*pdev)
>>                       goto free_irq;
>>               }
>>
>>-              err =3D request_irq(irq, mana_gd_intr, 0, gic->name, gic);
>>-              if (err)
>>-                      goto free_irq;
>>-
>>-              cpu =3D cpumask_local_spread(i, gc->numa_node);
>>-              irq_set_affinity_and_hint(irq, cpumask_of(cpu));
>>+              if (!i) {
>>+                      err =3D request_irq(irq, mana_gd_intr, 0, gic->nam=
e, gic);
>>+                      if (err)
>>+                              goto free_irq;
>>+
>>+                      /* If number of IRQ is one extra than number of
>>+ online
>>CPUs,
>>+                       * then we need to assign IRQ0 (hwc irq) and IRQ1 =
to
>>+                       * same CPU.
>>+                       * Else we will use different CPUs for IRQ0 and IR=
Q1.
>>+                       * Also we are using cpumask_local_spread instead =
of
>>+                       * cpumask_first for the node, because the node ca=
n be
>>+                       * mem only.
>>+                       */
>>+                      if (start_irq_index) {
>>+                              cpu =3D cpumask_local_spread(i, gc->numa_n=
ode);
>>+                              irq_set_affinity_and_hint(irq, cpumask_of(=
cpu));
>>+                      } else {
>>+                              irqs[start_irq_index] =3D irq;
>>+                      }
>>+              } else {
>>+                      irqs[i - start_irq_index] =3D irq;
>>+                      err =3D request_irq(irqs[i - start_irq_index],
>>mana_gd_intr, 0,
>>+                                        gic->name, gic);
>>+                      if (err)
>>+                              goto free_irq;
>>+              }
>>       }
>>
>>+      err =3D irq_setup(irqs, (nvec - start_irq_index), gc->numa_node);
>>+      if (err)
>>+              goto free_irq;
>>       err =3D mana_gd_alloc_res_map(nvec, &gc->msix_resource);
>>       if (err)
>>               goto free_irq;
>>
>>       gc->max_num_msix =3D nvec;
>>       gc->num_msix_usable =3D nvec;
>>-
>>+      cpus_read_unlock();
>>       return 0;
>>
>> free_irq:
>>@@ -1314,8 +1386,10 @@ static int mana_gd_setup_irqs(struct pci_dev
>>*pdev)
>>       }
>>
>>       kfree(gc->irq_contexts);
>>+      kfree(irqs);
>>       gc->irq_contexts =3D NULL;
>> free_irq_vector:
>>+      cpus_read_unlock();
>>       pci_free_irq_vectors(pdev);
>>       return err;
>> }
>>--
>>2.34.1
>>


