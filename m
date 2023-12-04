Return-Path: <linux-hyperv+bounces-1187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98360802E60
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 10:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE3BEB208B4
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 09:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4214F75;
	Mon,  4 Dec 2023 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P86MHjwH"
X-Original-To: linux-hyperv@vger.kernel.org
X-Greylist: delayed 951 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 04 Dec 2023 01:18:06 PST
Received: from HK2P15301CU002.outbound.protection.outlook.com (unknown [52.101.128.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E61CD;
	Mon,  4 Dec 2023 01:18:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFhx9EE1qlIX+Q7Zyf2D4ZpCzZMNr3lRbCIKNwsDTtJJM87BAH8zaAnoNt51L0PxpUgNGQ6zCNqbma3SLPM0s1s0hWbBfkG8BrI/lvUcLgRjYbt/7OZUwHXgBXkh8en77OT95TxuFa449qZCqPGPi0qqVVdj3Svw6FQ700tMKMoniOudvKi0LSdsEu2PxeRvQbBtCqoLNJV1MqkVucV5EJaeIgQO6akkv7d0+egWQEwllddGSRnja2kd9HosN5Z1Xm1RCc00ESydsNyX9iAcLwF8MPsyFPvR95HqrA2oHqiw6Nl1VkFIfw+xRWewBLALmEhHLIPO4DYHbxshw796jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPRXQ7jqmtZEeskhRlZXacQginW086HeJwETaGRIRxk=;
 b=jD0Q+UqaV7BdLrdc29FMYpA8rWOICQYTJg8jZjKOg0GORtISmBV7ySUvdzz2SBFXYr0ApWaUilLJHOar2gngkPBucVNncIB8BPTtw4G3NkPMIbFMuU4t/gORiXiD9yFSUCP5INDqeeoUv6e6/PZkjVRFY8t2HMceSul5yJZnaNcqaTLj5uQFv+r88VxudpKlymx872iuaYGkt+svt3jedpEhI0ymLCQ6lhs+/NW2d/6XWgatdnL1Bja7HDyyWFWo+ZLGfLqJSWPP74YIjrz/QzjMog8d8brYZWjpyePUTLQuH6OJ1cn3KPs7DoTBQWQWnEmnfk0MeRdYrL6V2hSaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPRXQ7jqmtZEeskhRlZXacQginW086HeJwETaGRIRxk=;
 b=P86MHjwHSLnKhJreAOndXGb4UtB+iqaMRFXl+0uXKywffS5JpEy8bXkX89lUNRd/DqGtkXrqVqP/IhDH0aCxVIzBExhtKAHGYBesBR+7nsnpTGpoZydZlqFlZqVdYsWAGGS8boBUo4p4YEN/8oDxrjUdDJmMyaC/DFqV91IknBk=
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM (2603:1096:301:fc::10)
 by SI2P153MB0656.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.5; Mon, 4 Dec 2023 09:02:09 +0000
Received: from PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a]) by PUZP153MB0788.APCP153.PROD.OUTLOOK.COM
 ([fe80::a516:f38b:f94e:b77a%7]) with mapi id 15.20.7091.001; Mon, 4 Dec 2023
 09:02:08 +0000
From: Souradeep Chakrabarti <schakrabarti@microsoft.com>
To: Yury Norov <yury.norov@gmail.com>, Souradeep Chakrabarti
	<schakrabarti@linux.microsoft.com>
CC: Jakub Kicinski <kuba@kernel.org>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "leon@kernel.org"
	<leon@kernel.org>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Thread-Topic: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Thread-Index:
 AQHaHIJKVWtqOkYgZ0uGtD+z/VnogLCFcX6AgAh9zECABD4XgIAApIsAgABRp4CABcJ08A==
Date: Mon, 4 Dec 2023 09:02:08 +0000
Message-ID:
 <PUZP153MB078896BF398A5879FC4B3E61CC86A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References:
 <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
 <20231121154841.7fc019c8@kernel.org>
 <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
 <ZWfwcYPLVo+4V8Ps@yury-ThinkPad>
 <20231130120512.GA15408@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ZWi+94B+N03pItJl@yury-ThinkPad>
In-Reply-To: <ZWi+94B+N03pItJl@yury-ThinkPad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=070f56b3-0de0-4fd4-8c66-df808ea91856;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-12-04T08:54:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0788:EE_|SI2P153MB0656:EE_
x-ms-office365-filtering-correlation-id: 5b4fe50c-633d-402f-d335-08dbf4a7b1d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4/ih3uNkuqIOS8zbfvbRD+W6oUtjJjT07PXR3m4nRN3NsZacoep6pw6rIL2qvfsd0XZjRifTgyxUoJg+X3B46gCmT3U/bdG5UaGcHmyBtCGaDoJWQTVY0ugNqDvkTIeXzj5nNnmUiYEKG4jKgkl68qhbFdor6qmnASZs2l/L+71qSWmyQqIhqKTG05lAxTx+UU7rpBWPx7REW07tZbQVPrTvHq2dqrGdZneSWG5BR9tC+sRq67Y50IUMkF3nBCqQthejjMvPOwjHTRBKtJ7K+nc41sCtrEBHNKUhYlj7hXqgRCitvI/Aw4jmOtXQs1perhQuxYmGjFBPkslVjy+snFnonDDxxWSsNtszXWLcYmDsqzk3hY077Y8bKC2U9nrtJNkWbFXeZdXMgg34UlxVwyoEDRiBKjBHlnH/blPifk7IgTjTcPS0+SyAoRoajTkrTMK+2jid+hHnmfaMsi6Ss7DdEBOseqb4rovZSl9cSPBt1Z8KTQciiWbVKA/Kr6uO+6RX26Jq3zpumaApOyAgphIMsl9Y/MKzMnaLdlIFOZoojKmYDI4ueS3q+vjj8WN/7i1jxv11bIhT1SuYi3ZRU0W/jEEaWLWneBCwk87uXvJ46lDf2myqsyUEOlk22SEgoFzhhdv9GrxgvoxTpgIoq2jt5+BtWneYnCLiF4oCXDeeIk8j67CKFr/EUmKWcWmMaWcMxYinEwPZMtArsHtrvTDAwStTWEOuzvZ3vzLgp/qiEMQ/uf/YHQIHEgHDcFbx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0788.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230173577357003)(230273577357003)(230373577357003)(230922051799003)(230473577357003)(1800799012)(186009)(64100799003)(451199024)(55016003)(6506007)(9686003)(7696005)(33656002)(86362001)(966005)(10290500003)(38070700009)(83380400001)(478600001)(107886003)(54906003)(316002)(64756008)(110136005)(76116006)(66556008)(66476007)(66446008)(66946007)(71200400001)(52536014)(8936002)(8676002)(4326008)(7416002)(41300700001)(5660300002)(122000001)(8990500004)(2906002)(38100700002)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5pu/+Kuj0ocApqRNTubJ6YkA28nKo/lcDn6K7usHpo66FfHDTzdthEDC5Ntf?=
 =?us-ascii?Q?zdSMKV8D927s4cMwCK9hy5xUfRsZKdca1cvhbhGmWM2KFRALwirvZgzl2OCL?=
 =?us-ascii?Q?gjpAF5KpTutslu+5ZHi1KT0F4jvZXY7590HZ9BT/6MLQxnGgBBnQtgwQ0tH4?=
 =?us-ascii?Q?iZj70h4EO+4EJJcUf9GML7KI64vLFpL6npCZMUqpbpZY6KAM3HKAJmQNAl/Q?=
 =?us-ascii?Q?Qy2Sl+R4oW3A4ZXH6ehcfw9Fwr7wwQBPi1JGzaOCkfqDQupLANHDvzoADb5P?=
 =?us-ascii?Q?yyHL4m3o+HGZLwReG08ZTB3lw8iw6+6SQA+pipGBPO3Nmm7AXtH0UH6Idsmr?=
 =?us-ascii?Q?QTFY5XMMHwz9orZG9xlqhmO42FVKmDM8NcekcSgueDgsn88vLbR+e0s4vPk2?=
 =?us-ascii?Q?zQenGSc+QmzoIOEobxE51pC1ZYifT0D3wOXQqY2N67VqAMKiUmNj0KtYFVyz?=
 =?us-ascii?Q?ip4nR0YTbv03xEf704887MQap6FSeI17qe47a94DcYv1dzkgH5iXr1oN2zBS?=
 =?us-ascii?Q?qO9o01lV/xUDVk+HM+/vCSyC3VTd6CjE/hNg0/qpdB3oKJx09EruITZcyPLr?=
 =?us-ascii?Q?cnzUQv6PvhIH541ePFR3zDuuvxQGpLfr7DBdNiC+pOl2R2hEYv/pJMGbgYo1?=
 =?us-ascii?Q?ndvoIFOhAgSNmhNfqfoF8MQ0tbgVCWzr4Ga+qux0vsCvB19tqosuZE2CJO8S?=
 =?us-ascii?Q?5uKgHyUSLWkD1vhgiHzPBBQV8RnH1WVg8lrssgNCKnX3PegUJpTS0wQdS4gs?=
 =?us-ascii?Q?N3ZHW3SA7t1ifBlLyITB6iKK4s+n3t8u0jc4ry2w0EbIkpl5Wx3Ip5TKkL9R?=
 =?us-ascii?Q?fxtLE6pYt1c5or3I37VB+h1eu2Swi5vmll9BIrgfyaiGH63yOwarMVmIh1//?=
 =?us-ascii?Q?XrFomZbV4ZSp6uFrbokiZ/OkuvKrUejUmf/a/aLELnUnbW3dH1+h5KGwD4s8?=
 =?us-ascii?Q?p0HZwg2acLcXtldkcOFj6xP87Qz38wUePiJagZ6UzX1X5R027laNUawtnqEu?=
 =?us-ascii?Q?CMMn1WbEVfFbuZm2bK4SOeD59WgbBQETo/+Trtf8dEaBmowLZvBNeKS2cbUA?=
 =?us-ascii?Q?GIXwOW9UCTrC5kt8vclXtYZEmBjctWxfXcdTYy/ytrgjgF/ywA2oR5P6Lqze?=
 =?us-ascii?Q?SRFKqwnW7AcmvoWHI7tIaRe8UgtX9J7Rojyf4kpeEPuGAy5DOTy21ovP85zV?=
 =?us-ascii?Q?ShswwkQ/59jljjvIIpg1vWADDWxLBj26XmMfNKnDJ6MVqQRAW0YpzZmCJrP+?=
 =?us-ascii?Q?pxth7vok9twn1s0IDgjXSYjySEdmi3wg902TZHoWUNd3dKJWTsgGOXMmLEK7?=
 =?us-ascii?Q?EX53lf9vWjU8jOG3cSFLnUI1oU9DVh9lnhzWHKm3qCZOXB0jclmDwnAbn80P?=
 =?us-ascii?Q?G2j2vdjPuVHxQDoVX94ZBVBAmkDrLmYTBkxdLOd+Hp6wGH3/jgi/CP72J89x?=
 =?us-ascii?Q?KxT4zIdw9fgJ8o2e4XZxztAjGH9T8qZibwhVBik7mVHjIE9tVQlH6J+9NcuO?=
 =?us-ascii?Q?AlJhubPwcbwvPMsJoz2UVFhxKQPjOi5l5Zbr5wP9Tmj/4/eFaNyNIQw0vPKY?=
 =?us-ascii?Q?bFMt7nkCnN1PLtQGtUCf5O1bBL1H/GelcfsUD9zq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b4fe50c-633d-402f-d335-08dbf4a7b1d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 09:02:08.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Swgt/7UqyRojm2u5X+YsNbwD7XjnjvD3474LTn8lu0HYXdAgaF8tq9YSQdbFAzaCsXmWfQBJOb2QAChnEw+ip8eFC/cijYzfp57LLiZDwYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0656



>-----Original Message-----
>From: Yury Norov <yury.norov@gmail.com>
>Sent: Thursday, November 30, 2023 10:27 PM
>To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>Cc: Souradeep Chakrabarti <schakrabarti@microsoft.com>; Jakub Kicinski
><kuba@kernel.org>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
><decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
>pabeni@redhat.com; Long Li <longli@microsoft.com>;
>sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
>ssengar@linux.microsoft.com; vkuznets@redhat.com; tglx@linutronix.de;
>linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-
>kernel@vger.kernel.org; linux-rdma@vger.kernel.org; Paul Rosswurm
><paulros@microsoft.com>
>Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
>affinity on HT cores
>
>[You don't often get email from yury.norov@gmail.com. Learn why this is
>important at https://aka.ms/LearnAboutSenderIdentification ]
>
>On Thu, Nov 30, 2023 at 04:05:12AM -0800, Souradeep Chakrabarti wrote:
>> On Wed, Nov 29, 2023 at 06:16:17PM -0800, Yury Norov wrote:
>> > On Mon, Nov 27, 2023 at 09:36:38AM +0000, Souradeep Chakrabarti
>wrote:
>> > >
>> > >
>> > > >-----Original Message-----
>> > > >From: Jakub Kicinski <kuba@kernel.org>
>> > > >Sent: Wednesday, November 22, 2023 5:19 AM
>> > > >To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
>> > > >Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
>> > > ><haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
>> > > ><decui@microsoft.com>; davem@davemloft.net;
>edumazet@google.com;
>> > > >pabeni@redhat.com; Long Li <longli@microsoft.com>;
>> > > >sharmaajay@microsoft.com; leon@kernel.org; cai.huoqing@linux.dev;
>> > > >ssengar@linux.microsoft.com; vkuznets@redhat.com;
>> > > >tglx@linutronix.de; linux- hyperv@vger.kernel.org;
>> > > >netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
>> > > >linux-rdma@vger.kernel.org; Souradeep Chakrabarti
>> > > ><schakrabarti@microsoft.com>; Paul Rosswurm
>> > > ><paulros@microsoft.com>
>> > > >Subject: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning
>> > > >IRQ affinity on HT cores
>> > > >
>> > > >On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
>> > > >> Existing MANA design assigns IRQ to every CPUs, including
>> > > >> sibling hyper-threads in a core. This causes multiple IRQs to
>> > > >> work on same CPU and may reduce the network performance with RSS.
>> > > >>
>> > > >> Improve the performance by adhering the configuration for RSS,
>> > > >> which assigns IRQ on HT cores.
>> > > >
>> > > >Drivers should not have to carry 120 LoC for something as basic as
>spreading IRQs.
>> > > >Please take a look at include/linux/topology.h and if there's
>> > > >nothing that fits your needs there - add it. That way other drivers=
 can
>reuse it.
>> > > Because of the current design idea, it is easier to keep things
>> > > inside the mana driver code here. As the idea of IRQ distribution he=
re is :
>> > > 1)Loop through interrupts to assign CPU 2)Find non sibling online
>> > > CPU from local NUMA and assign the IRQs on them.
>> > > 3)If number of IRQs is more than number of non-sibling CPU in that
>> > > NUMA node, then assign on sibling CPU of that node.
>> > > 4)Keep doing it till all the online CPUs are used or no more IRQs.
>> > > 5)If all CPUs in that node are used, goto next NUMA node with CPU.
>> > > Keep doing 2 and 3.
>> > > 6) If all CPUs in all NUMA nodes are used, but still there are
>> > > IRQs then wrap over from first local NUMA node and continue doing
>> > > 2, 3 4 till all IRQs are assigned.
>> >
>> > Hi Souradeep,
>> >
>> > (Thanks Jakub for sharing this thread with me)
>> >
>> > If I understand your intention right, you can leverage the existing
>> > cpumask_local_spread().
>> >
>> > But I think I've got something better for you. The below series adds
>> > a for_each_numa_cpu() iterator, which may help you doing most of the
>> > job without messing with nodes internals.
>> >
>> > https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flo
>> > re.kernel.org%2Fnetdev%2FZD3l6FBnUh9vTIGc%40yury-
>ThinkPad%2FT%2F&dat
>> >
>a=3D05%7C01%7Cschakrabarti%40microsoft.com%7C79dfb421db6f463627250
>8dbf
>> >
>1c5c19e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6383696
>04095521
>> >
>996%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
>MzIiLCJB
>> >
>TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sdata=3DpDUpYWo3K7
>uoz2q50GQ
>> > 1UKuPF2PwFagiT5pwrXhQXPk%3D&reserved=3D0
>> >
>> Thanks Yur and Jakub. I was trying to find this patch, but unable to fin=
d it on
>that thread.
>> Also in net-next I am unable to find it. Can you please tell, if it has =
been
>committed?
>> If not can you please point me out the correct patch for this macro.
>> It will be really helpful.
>
>Try this branch. I just rebased it on top of bitmap-for-next, but didn't r=
e-test.
>You may need to exclude the "sched: drop for_each_numa_hop_mask()" patch.
>
>https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
>b.com%2Fnorov%2Flinux%2Fcommits%2Ffor_each_numa_cpu&data=3D05%7C0
>1%7Cschakrabarti%40microsoft.com%7C79dfb421db6f4636272508dbf1c5c1
>9e%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C638369604095
>529277%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV
>2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C2000%7C%7C%7C&sdata=3DW
>wmd%2BvQS7YHIwFKyL9OLd8iYttJ4ZIqQyxU3Ex8UOkY%3D&reserved=3D0
>
>> > By using it, the pseudocode implementing your algorithm may look
>> > like this:
>> >
>> >         unsigned int cpu, hop;
>> >         unsigned int irq =3D 0;
>> >
>> > again:
>> >         cpu =3D get_cpu();
>> >         node =3D cpu_to_node(cpu);
>> >         cpumask_copy(cpus, cpu_online_mask);
>> >
>> >         for_each_numa_cpu(cpu, hop, node, cpus) {
>> >                 /* All siblings are the same for IRQ spreading purpose=
 */
>> >                 irq_set_affinity_and_hint(irq,
>> > topology_sibling_cpumask());
>> >
>> >                 /* One IRQ per sibling group */
>> >                 cpumask_andnot(cpus, cpus,
>> > topology_sibling_cpumask());
>> >
>> >                 if (++irq =3D=3D num_irqs)
>> >                         break;
>> >         }
>> >
>> >         if (irq < num_irqs)
>> >                 goto again;
>> >
>> > (Completely not tested, just an idea.)
>> >
>> I have done similar kind of change for our driver, but constraint here
>> is that total number of IRQs can be equal to the total number of
>> online CPUs, in some setup. It is either equal to the number of online C=
PUs or
>maximum 64 IRQs if online CPUs are more than that.
>
>Not sure I understand you. If you're talking about my proposal, there's
>seemingly no constraints on number of CPUs/IRQs.
>
>> So my proposed change is following:
>>
>> +static int irq_setup(int *irqs, int nvec, int start_numa_node) {
>> +       cpumask_var_t node_cpumask;
>> +       int i, cpu, err =3D 0;
>> +       unsigned int  next_node;
>> +       cpumask_t visited_cpus;
>> +       unsigned int start_node =3D start_numa_node;
>> +       i =3D 0;
>> +       if (!alloc_cpumask_var(&node_cpumask, GFP_KERNEL)) {
>> +               err =3D -ENOMEM;
>> +               goto free_mask;
>> +       }
>> +       cpumask_andnot(&visited_cpus, &visited_cpus, &visited_cpus);
>> +       start_node =3D 1;
>> +       for_each_next_node_with_cpus(start_node, next_node) {
>
>If your goal is to maximize locality, this doesn't seem to be correct.
>for_each_next_node_with_cpus() is based on next_node(), and so enumerates
>nodes in a numerically increasing order. On real machines, it's possible t=
hat
>numerically adjacent node is not the topologically nearest.
>
>To approach that, for every node kernel maintains a list of equally distan=
t nodes
>grouped into hops. You may likely want to use for_each_numa_hop_mask
>iterator, which iterated over hops in increasing distance order, instead o=
f
>NUMA node numbers.
>
>But I would like to see for_each_numa_cpu() finally merged as a simpler an=
d
>nicer alternative.
>
>> +               cpumask_copy(node_cpumask, cpumask_of_node(next_node));
>> +               for_each_cpu(cpu, node_cpumask) {
>> +                       cpumask_andnot(node_cpumask, node_cpumask,
>> +                                      topology_sibling_cpumask(cpu));
>> +                       irq_set_affinity_and_hint(irqs[i], cpumask_of(cp=
u));
>> +                       if(++i =3D=3D nvec)
>> +                               goto free_mask;
>> +                       cpumask_set_cpu(cpu, &visited_cpus);
>> +                       if (cpumask_empty(node_cpumask) &&
>cpumask_weight(&visited_cpus) <
>> +                           nr_cpus_node(next_node)) {
>> +                               cpumask_copy(node_cpumask,
>cpumask_of_node(next_node));
>> +                               cpumask_andnot(node_cpumask, node_cpumas=
k,
>&visited_cpus);
>> +                               cpu =3D cpumask_first(node_cpumask);
>> +                       }
>> +               }
>> +               if (next_online_node(next_node) =3D=3D MAX_NUMNODES)
>> +                       next_node =3D first_online_node;
>> +       }
>> +free_mask:
>> +       free_cpumask_var(node_cpumask);
>> +       return err;
>> +}
>>
>> I can definitely use the for_each_numa_cpu() instead of my proposed
>> for_each_next_node_with_cpus() macro here and that will make it cleaner.
>> Thanks for the suggestion.
>
>Sure.
>
>Can you please share performance measurements for a solution you'll finall=
y
>choose? Would be interesting to compare different approaches.
I have compared spreading IRQs across numa  with IRQs spread inside local
NUMA, and the performance was 14 percent better for later.
I have shared the V4 patch with for_each_numa_hop_mask() macro.
>
>Thanks,
>Yury

