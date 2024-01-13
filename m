Return-Path: <linux-hyperv+bounces-1431-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D6882CDB9
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jan 2024 17:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B95C1F21A1E
	for <lists+linux-hyperv@lfdr.de>; Sat, 13 Jan 2024 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5082257A;
	Sat, 13 Jan 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b+JDKlkc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2034.outbound.protection.outlook.com [40.92.42.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488023A8;
	Sat, 13 Jan 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFQnd6V6Cue25DJw+y6Gl46lurN/+IKLUhbpCyZSsRvxx76mzvVuSAwBnqpm6emRbalPjReapB5/GCyFil0T1FYBMznVY6BY597loJu0kxlqL/vpbzFE7kKkTljXUE2H8pT1Zp33lAb8H/R0MnUSBk5CtEtHD5HLpIesMGX2ANxQHGeSzZzo/IEVgObU0cUtiROFze7GSqGjDjoorbKJ0iOlMjK5LtnBbKNnAPOvxBIKowH66x2upLy/VV/8NzzbLHjW9C3bGsO8lUBXINE8SOXzM8RAhlutzRRBzqA3mPaHBdEOH/Rq06GY7CsPp1LcGgOlpFkNtT7XsvFCculvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSNCYEnIPc3K3zs1455/jy6YEX4Ev0iID3ejnr+liFs=;
 b=Bg7nBnm1DlDwG3xcRgLVTVKjZdfivCc3g3u2n3cvvx6fjoUGpxRjzJ8cWxPhmfdSJhCtl11A9izYos2sMyYzLmdW4V7SycjWE1f7S14RIx475LfFS4w966om170pXve+skibz4OYCZkKXz6XksMi9DwEoHaLA9prKGUlF3rIP6Jk6oh+4oGWLkYVt7ui2DalQsmGCcFRQpo66JhnB4vNFwjhkL/5vfhAOZQuZAuk/NzIgukzr6loa8kqL32R2xNwRBLE5df9bSvMGFBQdN39WnfqxLt2A0Yzh3FaGixmMz4fmqri0uQiNttBMB6SDgmFfI3OUvuF55hxX68vg+kF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSNCYEnIPc3K3zs1455/jy6YEX4Ev0iID3ejnr+liFs=;
 b=b+JDKlkcxUCrySCvX5xe/lvn2l10Eam2VLIWD+0FtIIaPsPjr/TA/OKB+lSypP8sDtAKjg4XW0ruWlLwGMdwNbnK15nCotVspIVKHB7sZTCXTmw1tVP08jb4qlyzDQ1MkV96551G85UdTSjyMpudYwU0ufdX6NUSmAhRGJrcXdNEsYXAZmlvxxWzinQh0bv0Uq9R+R2/wS/qD16VVsyQAqCzDimuGQG49fmqdaYHyXmJt8BtRh14GhsIWMN6wDusemePqVguirkYVPpwO2ArvFzoM4XyBGpr0GZC0pc4iCxFtsi4h//Jmo18P8tuQFcTBVpR0rEHVXXZj7SVdREB2g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB8820.namprd02.prod.outlook.com (2603:10b6:303:144::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Sat, 13 Jan
 2024 16:20:31 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::3524:e4b3:632d:d8b2%4]) with mapi id 15.20.7181.015; Sat, 13 Jan 2024
 16:20:31 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>
CC: Yury Norov <yury.norov@gmail.com>, KY Srinivasan <kys@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>, "cai.huoqing@linux.dev"
	<cai.huoqing@linux.dev>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Souradeep Chakrabarti
	<schakrabarti@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs per
 CPUs
Thread-Topic: [PATCH 3/4 net-next] net: mana: add a function to spread IRQs
 per CPUs
Thread-Index:
 AQHaQuoWNi7Bv1N390Ch4p7DlTYrcLDR1sMggABKpoCAAAdtgIAB++CAgAI7qHCAACS1AIAAySQAgACjPeA=
Date: Sat, 13 Jan 2024 16:20:31 +0000
Message-ID:
 <SN6PR02MB4157372CF70059E8E35D5545D46E2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1704797478-32377-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1704797478-32377-4-git-send-email-schakrabarti@linux.microsoft.com>
 <SN6PR02MB4157CB3CB55A17255AE61BF6D46A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <ZZ3Wsxq8rHShTUdA@yury-ThinkPad>
 <SN6PR02MB415704D36B82D5793CC4558FD4692@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240111061319.GC5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157234176238D6C1F35B90BD46F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <DS1PEPF00012A5F513F916690B9F94D3262CA6F2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
 <20240113063038.GD5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
In-Reply-To:
 <20240113063038.GD5436@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [DMDsAoa+8qlwJMXA9a5Bnnq7QuWkTMCc]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB8820:EE_
x-ms-office365-filtering-correlation-id: 431a1d7c-ad08-4755-45c7-08dc1453907e
x-ms-exchange-slblob-mailprops:
 znQPCv1HvwUBoHQ5Um8OzrjRlvODcqPyU1POlJMrxpxeOZuJ/9380I62im9Ll7UQlzE22g3+gd2nO1XUh+jjWcr6uF+WCwCorC+9Wrp5whRyO7Ev3ik/dnIlxLKUPyGf9q6xVlPe2MuP0y7r0B8D6rBNxRg7ENfBnK3lqY3axD56NE4MN2gIeLNGogb3hcaoTqIvG+LM1pRapig3glCyVmVbrlxH0//bNh6Q/VmIZMqHNMAhu+UEBv1QTODVTH2Sm8VCBmRN3Gc5nr/rp2Jdue7hgEkl28RjCktmWT28BP7xivHuZq+im58T2XLLN/IWRRMbSWo8vrPEBPh3krudHH9NHBeBAMvDL5AVmTExlP2XKgY3u0ivFMsM2o7OTfjSyVEH1RUDxQndiCurhN0niJnjmavggFWIX3LHntzqnGhRHc+PQ377kg/OmiIuASFLxJtEx+UIzKyis2PXOeDsXC+5rBXu20+J4IqfeY4mdey9fnVR+UcLoefMU6ZRcCdH3frPnLYZqjxIHplY/0EhgxkJ3FHwYxETB1tkKjsHWd+qyQ5HGdwVKOITIRN6BgWWoWog3yaM3+SYmStm94myVfE31ABuD3VG2v7t+YfvxDeWn6+XC9rIPsKuzi+imoIv7sVzNf27dv80jUX7U5Lig8f2795uA8WLxTTPcYFuIUgRnMe4mpCP8mAXXGv6pWYWWlOvnSL+J0ioAGuSREGVCOndRw31zWUVsEb7wrfLa4rpFYmrMaZ7w9KzSdTVv6urvPdV2NT+jCw=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IG3Ck4wLITAZqaexRSSlWYjxICKOGam18Dgn2ztyopW+1NNsvOwv8VNl70eOwAv38scDbZhT6zQNMXtuQSxNs/s+CSMio99iJSQoGWV4BZ7swsqtXnAK2mAUrziKdrh1xDJqFOApZ/o8IIvJfOrI1jVkIHqV2pKOSzh8bspEl9aVwmAl/rR4KRdQkEIWTlNunXqb+L4juKJhODmUULpma2pEUvNwdGZSzIk6gEDdONicaZXLMmpdDp4g1j43gOFs1F5C5mIfP0n1gnlY/mq2OWE80nTnCeJPDTDxyw46MGQp6ODFG0UxhgvTpr+9U494aNTf85rX1j5phcs3SOe8ZYApjyoYotX0eesoiPOMzgKR2F6C9lT3TR6ofzr5DG4KYFttSsQdu/56tXgvRAaGI6FdwbHsoJe+kZe35ulptDtIzH5t3hg5Yb4f5fn/fUFYMIhQ5ZU9tEzWoLXXa2v4eCdwuuROJ+44kxCRn/U5T4BEdxwI1jHhrzyvnxjsxoKXhBhxjICiQrY7toUbEbz99oNyaz44/jM8lOUDPwPco9nteEjubfbNv5LtDxxUujBk
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hAmHN/72lnZPuI9t1POPsUzCQGKVmGbW2CLITT0jOrYrCma1c4fV72fOkSc4?=
 =?us-ascii?Q?5wMwaYSlgfDAc4MHi8c6IhLh2lr9u/l4ok9Wmvc702TxSFnVfttCa9a5jFPU?=
 =?us-ascii?Q?7FYfl/Jqh/kE+3rUnPgGTpPDPwBHLnZp2gFJy5DPdQdKcfvTJtTyTamYEGJU?=
 =?us-ascii?Q?UB3k+nDONDdQ67gXqa7kE+hipEovTi+QBE3SIf0l/8/wM7HDjjPafQkM39QM?=
 =?us-ascii?Q?fD1L4eD9LWB8y2xVQiXWvPnxTt28qYrjpkA2eBEUPS7duQqAOLA+RiTRnNy6?=
 =?us-ascii?Q?/MScMOMTWVK+wxsvsdlroRoBi9Iglpg9AD9/nbDk7jIFUnD+Pelar5wDIVZr?=
 =?us-ascii?Q?F1huMQsoloOgKwDiXXmAH994pGEWVcvkF7UnsvGel9LqDGY5F9eTOo+muUv1?=
 =?us-ascii?Q?9D57U0TB4ApRqnYwzcKXongU0QOATFnXPRXqCa6/3B2SRnBam/CBu2novTIY?=
 =?us-ascii?Q?+yqe3q20aQkOtqirQOgfW3qvd03rbel1OgeuNjTS2jF2wN5o+t4BBTTi+sFY?=
 =?us-ascii?Q?9GXPaCd3r9hROLt5lJfINCGJpH4LBX3G/A5YM+3lJ6x1B/vpnPhZW4+lscQj?=
 =?us-ascii?Q?icCAF/n7mCUaahM07End9oFr4yYToTSnG2zJYqFPB9t5siyIWUhinBhe35Ir?=
 =?us-ascii?Q?AUM+CwLlTaHpRneR1Q7GugvP3Ntjwrs1d0M7O/rkDsCo9FS0JoOxLfKG3pSN?=
 =?us-ascii?Q?l1YMRaYTBhJPspmVYLiHPNSQ1byW9IarJGfIf8YPISlZAfHh38xKq8HgZ6RX?=
 =?us-ascii?Q?fqIePgvBaywMsnsL6J7mxH/9envTflC/Cj6TAP0h741g/7ZTYF2P0kL3Uuls?=
 =?us-ascii?Q?0a+eOj9NWgLRF76Uq7CldYbysdyEw+zckLDlm6kjoGObeG8ycnplzFTH2oYP?=
 =?us-ascii?Q?QOv3SR5RCiNmcNDcXsAvxnsoemgelUkTErMhGMLWroPckm6tpMPtiCSizdbK?=
 =?us-ascii?Q?hFDUuwqh/Ovp7943zNYlzTsA3hTpAzuBcbD25Mo2amLr+ZoFBNhkbRyymhz/?=
 =?us-ascii?Q?Ggc0au6XryPTiOPIdgrt/Boiew/UIib7soK1t4Z8ANWN/HI6n5wIUy8X0T3o?=
 =?us-ascii?Q?+/Ql2FM94ybdAweLhRf4+5mEd4LDHVNTqJ31TrSRiiGyxsjJE79QCt0qY2DU?=
 =?us-ascii?Q?Wn8LJvsqkhlHacMRlG6+f1WEEam3+pdSm3Vp3maAGPCMHy+PcXpCmQt1WrHZ?=
 =?us-ascii?Q?W/CymYu/NLzJ6uTtH91NBBoegVQ7ufuNk4AxZQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 431a1d7c-ad08-4755-45c7-08dc1453907e
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2024 16:20:31.8466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB8820

From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent: Friday=
, January 12, 2024 10:31 PM

> On Fri, Jan 12, 2024 at 06:30:44PM +0000, Haiyang Zhang wrote:
> >
> > > -----Original Message-----
> > From: Michael Kelley <mhklinux@outlook.com> Sent: Friday, January 12, 2=
024 11:37 AM
> > >
> > > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com> Sent:
> > > Wednesday, January 10, 2024 10:13 PM
> > > >
> > > > The test topology was used to check the performance between
> > > > cpu_local_spread() and the new approach is :
> > > > Case 1
> > > > IRQ     Nodes  Cores CPUs
> > > > 0       1      0     0-1
> > > > 1       1      1     2-3
> > > > 2       1      2     4-5
> > > > 3       1      3     6-7
> > > >
> > > > and with existing cpu_local_spread()
> > > > Case 2
> > > > IRQ    Nodes  Cores CPUs
> > > > 0      1      0     0
> > > > 1      1      0     1
> > > > 2      1      1     2
> > > > 3      1      1     3
> > > >
> > > > Total 4 channels were used, which was set up by ethtool.
> > > > case 1 with ntttcp has given 15 percent better performance, than
> > > > case 2. During the test irqbalance was disabled as well.
> > > >
> > > > Also you are right, with 64CPU system this approach will spread
> > > > the irqs like the cpu_local_spread() but in the future we will offe=
r
> > > > MANA nodes, with more than 64 CPUs. There it this new design will
> > > > give better performance.
> > > >
> > > > I will add this performance benefit details in commit message of
> > > > next version.
> > >
> > > Here are my concerns:
> > >
> > > 1.  The most commonly used VMs these days have 64 or fewer
> > > vCPUs and won't see any performance benefit.
> > >
> > > 2.  Larger VMs probably won't see the full 15% benefit because
> > > all vCPUs in the local NUMA node will be assigned IRQs.  For
> > > example, in a VM with 96 vCPUs and 2 NUMA nodes, all 48
> > > vCPUs in NUMA node 0 will all be assigned IRQs.  The remaining
> > > 16 IRQs will be spread out on the 48 CPUs in NUMA node 1
> > > in a way that avoids sharing a core.  But overall the means
> > > that 75% of the IRQs will still be sharing a core and
> > > presumably not see any perf benefit.
> > >
> > > 3.  Your experiment was on a relatively small scale:   4 IRQs
> > > spread across 2 cores vs. across 4 cores.  Have you run any
> > > experiments on VMs with 128 vCPUs (for example) where
> > > most of the IRQs are not sharing a core?  I'm wondering if
> > > the results with 4 IRQs really scale up to 64 IRQs.  A lot can
> > > be different in a VM with 64 cores and 2 NUMA nodes vs.
> > > 4 cores in a single node.
> > >
> > > 4.  The new algorithm prefers assigning to all vCPUs in
> > > each NUMA hop over assigning to separate cores.  Are there
> > > experiments showing that is the right tradeoff?  What
> > > are the results if assigning to separate cores is preferred?
> >
> > I remember in a customer case, putting the IRQs on the same
> > NUMA node has better perf. But I agree, this should be re-tested
> > on MANA nic.
>
> 1) and 2) The change will not decrease the existing performance, but for
> system with high number of CPU, will be benefited after this.
>=20
> 3) The result has shown around 6 percent improvement.
>=20
> 4)The test result has shown around 10 percent difference when IRQs are
> spread on multiple numa nodes.

OK, this looks pretty good.  Make clear in the commit messages what
the tradeoffs are, and what the real-world benefits are expected to be.
Some future developer who wants to understand why IRQs are assigned
this way will thank you. :-)

Michael

