Return-Path: <linux-hyperv+bounces-1907-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F67B895912
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 18:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13BC1C23B6F
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 16:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1E9134404;
	Tue,  2 Apr 2024 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Fg6+oBLF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11021007.outbound.protection.outlook.com [40.93.193.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E81339A2;
	Tue,  2 Apr 2024 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073555; cv=fail; b=eWINz68yPv+YZhOD6W9np2eqG1oIA/0/WLeVyEiVLYTVBw1ZdZdfISqhtNqY6xpKXnNIU9DnpoU2ZQPi73ASkMmA7c5GINRK3PaXIRSMEUDKRXrOgWMH2JeL2Bxf7p0IrRweNxybH+DfuzVMXYmxJrG2sCqitDkXypiDYS2PUC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073555; c=relaxed/simple;
	bh=NeNaejfMC7iiF9gxlUZ93q1HNuWeqqwi3LPabF2hA8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aTOT88HbovgKaOGk9Xjby5rYtWE3ptmE9FeVoAQKAgeLB9mR8udf+4un4PW7EFKOFNG3OpDbExeZbMzEV8aEgcg60sTsscWfhGgVuQWBojwymRlZZCnz70ZZR6fxwXdnxaiLm9Nn9amxzpby7i/n85ifc5VMnswDiBur2rixddE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Fg6+oBLF; arc=fail smtp.client-ip=40.93.193.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nnl5G1uFSDTO5rGLEt95GkxLnAqtZlWEr1NhGaphNx0iV5rEFoAHb+Rt1U9oKT9j5cleV6xjpUuVfb4QMgJ+rmC1WETWsBOB0m1sGfulNORamzz+iOluUvpgf8DC3uQdCHnzMZDlqPq9jahbga3zOE16nKIpHr3ttKxhFR8le7tEZ4Gd8H0l5WHlx6nTbYsPILU4w9wBg9N35aRD8PpA4Ba1A3Zu7EoUXvMsFpAJFO8PYJuacmyyd4GHuWMqnNebqFuTAw/Wo68q5FgJLGuoggFC1kqOMJDKarYNKViL85PUcsgRlRupyNSRtfPtlSL0SM9Crz2kET8oZVZYJseqOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHcebN8JleKU4HvWwj3Sl4FbtCNDR4UzDQdk5N3ohYU=;
 b=gLH44rmW+4my/nnTLewntQi4W0xjumEqFWeMlD5pwzvQVdi+IqsHLE1ZzpgZ4NrtHu2QToimaex1TYFU0A8o+cmQqXV4OLhaogjfb2m6SrjaoxsY3Mx4keS9uaLIQzVW32GEyFudnZevllsMdoU6Qavt2qVU1kP6m6nzzcb7zVYHo9HZRBUsjI5AXlWLxcuSFXRtkpBi+vOvS+3ibqzbeBrf8cRAh2RGK06wHL4eXkoiQTktVSaAIWnYQBPEO68gVHFbSLgg5xSH+ZmzES7sR29y6/BSHnGVbiQconZFlA8MAxU9X6BF1Gr7k7HdgZlCOr3AJRlHTH/h2PbF3BqJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHcebN8JleKU4HvWwj3Sl4FbtCNDR4UzDQdk5N3ohYU=;
 b=Fg6+oBLFknQXV1SGvQsiyDR+orRXPxktdqFAp/QBVZHmAIqEBhgtDQ2FPwpsi8DlAtQPs5JUNrE+57OJCukUdGjoRPs2WO82OG8VzbJgCSfVPHl3MPr6TVXefOR+rjwq7jhok5BbAZt4MZeM+oZtqn6K6mV52lqHsdPJcbbvMu4=
Received: from DM6PR21MB1481.namprd21.prod.outlook.com (2603:10b6:5:22f::8) by
 PH0PR21MB1895.namprd21.prod.outlook.com (2603:10b6:510:1c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.16; Tue, 2 Apr 2024 15:59:11 +0000
Received: from DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e]) by DM6PR21MB1481.namprd21.prod.outlook.com
 ([fe80::93ce:566b:57a1:bb4e%4]) with mapi id 15.20.7472.007; Tue, 2 Apr 2024
 15:59:11 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Dexuan Cui <decui@microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Wei Hu
	<weh@microsoft.com>, stephen <stephen@networkplumber.org>, KY Srinivasan
	<kys@microsoft.com>, Paul Rosswurm <paulros@microsoft.com>, "olaf@aepfle.de"
	<olaf@aepfle.de>, "vkuznets@redhat.com" <vkuznets@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "leon@kernel.org" <leon@kernel.org>,
	Long Li <longli@microsoft.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "hawk@kernel.org"
	<hawk@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Thread-Topic: [PATCH net] net: mana: Fix Rx DMA datasize and skb_over_panic
Thread-Index: AQHagiFTMR5ZlnaVikeExhfsF+DuY7FPaYIAgASmJ+CAACS3AIAAL1UAgADFKBA=
Date: Tue, 2 Apr 2024 15:59:10 +0000
Message-ID:
 <DM6PR21MB1481D2981B497CB339D84CBBCA3E2@DM6PR21MB1481.namprd21.prod.outlook.com>
References: <1711748213-30517-1-git-send-email-haiyangz@microsoft.com>
	<CY5PR21MB375904FD3437BA610E6BDBD1BF392@CY5PR21MB3759.namprd21.prod.outlook.com>
	<CH2PR21MB1480E02C74E7BB5A52A71859CA3F2@CH2PR21MB1480.namprd21.prod.outlook.com>
	<CY5PR21MB37590FD539C1E380FBDC96B0BF3E2@CY5PR21MB3759.namprd21.prod.outlook.com>
 <20240401211232.57b17081@kernel.org>
In-Reply-To: <20240401211232.57b17081@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7a53aba1-ff31-4942-97c5-083718b803d2;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-02T15:58:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR21MB1481:EE_|PH0PR21MB1895:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4noJW76wByI4bGQgenQ7ju6ZHDd+36JykCVsd8MCMMMZ1ATfv0AWoaYonq9PjCVdfc3aeU4OTh1X443erMMqk7Vz+ohAPdJDSoOn7VcHOy+dt5cn/AWj+y6jKtqm+NPtq8SGKngX0EH+R/WD1eIsXe85nyY75je1cvfD0NFkTqaMHpLCjQ5AoejBECGUAz4jiPlED2xTn445fQwPvVeDqbU60LbVZD9TpkniKGab+9++ti3YKngatQyeROGGzbZxsfgl3qY9bzKb1cQeAEl24mD85ORS67FOanJ+57wH1JE4VkDO1vLumKXsvzC+vw9ftNb6Vt898GNMkoUvkBKbMaO46cR0EWtDx7G91U5UUx7IvI3pEoPDK0GO+IYo91j9G73DsbXDI0a5AF36IX4BjpasJHtsPcA2JZlCzIQvSLO8Nxu60tlyoDXH2G3RqpSvvlOWHvx6C99AIF44S0XR/yjNmKHW/HH/wAT9etvl/WdhEmv3syxv50kehR+1sO9X7z3XeNzcWZUQXJ41Mkef+rd70D7qYVLooDRGAWoNxA096lCw8jeKfvruosDaOT6B8TKjepbmW0dSfbqjlgk1Abqd4RaSekGPd7sI0lrvSVZ6MVwSSA51kYJTZLTNOV+9ZK9owobWi8hYxfh3tXU9Sw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1481.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YiC2Z4s3wHbecuru4/m6dxVHXVIaFIrgoHoEvgj9krtlSvww2rJGJagZQn56?=
 =?us-ascii?Q?JhgjzjCq4iZKSdyBrska3ub6G3kzRCjfx4ef2uhoOQkcS4Ale+gKKcwWxlRw?=
 =?us-ascii?Q?OAVObSfgaKaN6z6OZ2Yfdayng66AJLiMyUdIK/PzmxOMHgVK3iIUYgSKACHv?=
 =?us-ascii?Q?jsR+W2h3j4u+tPC2DhDZrTuQ8RrQxiYKIzNoBSBwnCZ0m2tgGO8Dl9/Fx08y?=
 =?us-ascii?Q?4TPz/+tVmsVGF1nEHmpEb0Rj8oIQZNBkYm2vwfRqRJ4ptJgyyVEH1VVTagUo?=
 =?us-ascii?Q?EgqLH8tGGqtTR1E2nKh3PRJiNk/6Z881RDBWRRtvNNRFX+tgFnmdRTkbbRWy?=
 =?us-ascii?Q?FFDNaKiUnRXoNxdlfnkT/ZaYJZjnSSfng/HiqlkHjjTQ8siR5lpZczlczq8E?=
 =?us-ascii?Q?TLBbElZBsYMEdqPryB54CisAYXVmm6l/QfXplonEe8KMS3tt5phTDowImBxL?=
 =?us-ascii?Q?k1/M50WiazziHnMTegw6CDap+O+IddDrn2f4HB/wZeoTPCfFgdGpRwvkbOre?=
 =?us-ascii?Q?4hDaEj5lEmomhSTDg54dFBEbdORXqnuMwRhOZRMoDCyPlvumpl+6a50pSDPX?=
 =?us-ascii?Q?n+cWP88cN5mWvK4LjBKXT27GO4z1FuAkbqt5YaoNT6iFo39Ln9O6rzuT0PSj?=
 =?us-ascii?Q?Z75snVvmH7gzgzbrFoGv2r0C3gQ37tqiYHkGWopFqodGjjs0CE7so7yoiui7?=
 =?us-ascii?Q?M022mPBA4YQubr+4pJiqTPGXUSpMIGdaKOIrLwhJ84IkZm3nNYseVAv4u0H8?=
 =?us-ascii?Q?BUJfWRFjRr6K8HwW50KMA4Rw1czdNNJrTxfsLJ6kCd6BIVTjQEtYLgcNRVYg?=
 =?us-ascii?Q?3aPpdxGZnWb2iBduc4qQJtsVLpFIgWcLtAbywbEcbbeyXxwv/fwXgQPKOJ/M?=
 =?us-ascii?Q?uYItGz25wRMT7ugV/kdBqAOZgP0/Zuzbv+u8XBa9eAsBMzzlOpqz4j3ddJHC?=
 =?us-ascii?Q?1wG2anliXKjGD5WZkBRhjNtW0nZWpT/Z5UVcd1fAK7Gz4ZAhxRSuszOMqXnZ?=
 =?us-ascii?Q?Fkr6FBCkSgl6h55kul822rKZyKc5aiEnRQprpd9LuaMOxAIKcnL6iK23xwYS?=
 =?us-ascii?Q?uef7L0PYxbxfsefmLszQXDWNH2ZrWZzxcc2fznl0m2p4X4vsNS6K1EUvoLXx?=
 =?us-ascii?Q?EFdlHq7k+pyWGeP16r0FyKk907ezLoDxE63U3wrB47LRarh08g6/eOQ42OC9?=
 =?us-ascii?Q?DYmYdYj50iwYDk/wmw4vLO6XbOEuITF+AevhI19TMsB34vAULuURkFlz5xIJ?=
 =?us-ascii?Q?5jEPfOwxW5+grMJsU7/rUUWABffUEwaTRRTYLpXjiG2CiX8yDjXN0x1PoFww?=
 =?us-ascii?Q?VxixvmrCJ7S0EPTJK8daC5hFkPFa/m46RJ3WmLUnjBHgJb6soxGnfyC1ju4F?=
 =?us-ascii?Q?f/RXgtzHF6UtNMY26nQcBZMQl7vhbhr5VCQmBo/wbAnSp3APXagfn/5444vJ?=
 =?us-ascii?Q?eLUy+bYV/90/lGAElzLLlAdxcv9ZXsLaIOY6x9AIHxk5yhOAw3RNsHVgx25D?=
 =?us-ascii?Q?hQ4lID7iTm8ZA9HubzT61u7d35nHsdYdJeBeAl/pnTJXQsYujNyNXnsV8nZm?=
 =?us-ascii?Q?ybis8A63Fm2d/OwJ8r8MMWjTgQf+004XM57Rz9Z+?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1481.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cc9c57-0634-40bc-b68f-08dc532dd60a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:59:10.8862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tx39MD5Sa15a5jZuJs9NSNqLHaYF3H5zhORVWY4sDxXfO8oB6oXCbNOSUek9I1n5wFsxf6BN9KqrkzFNtml6eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1895



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Tuesday, April 2, 2024 12:13 AM
> To: Dexuan Cui <decui@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>; linux-hyperv@vger.kernel.org;
> netdev@vger.kernel.org; Wei Hu <weh@microsoft.com>; stephen
> <stephen@networkplumber.org>; KY Srinivasan <kys@microsoft.com>; Paul
> Rosswurm <paulros@microsoft.com>; olaf@aepfle.de; vkuznets@redhat.com;
> davem@davemloft.net; wei.liu@kernel.org; edumazet@google.com;
> pabeni@redhat.com; leon@kernel.org; Long Li <longli@microsoft.com>;
> ssengar@linux.microsoft.com; linux-rdma@vger.kernel.org;
> daniel@iogearbox.net; john.fastabend@gmail.com; bpf@vger.kernel.org;
> ast@kernel.org; sharmaajay@microsoft.com; hawk@kernel.org;
> tglx@linutronix.de; shradhagupta@linux.microsoft.com; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH net] net: mana: Fix Rx DMA datasize and
> skb_over_panic
>=20
> On Tue, 2 Apr 2024 01:23:08 +0000 Dexuan Cui wrote:
> > > > I suggest the Fixes tag should be updated. Otherwise the fix
> > > > looks good to me.
> > >
> > > Thanks for the suggestion. I actually thought about this before
> > > submission.
> > > I was worried about someone back ports the jumbo frame feature,
> > > they may not automatically know this patch should be backported
> > > too.
> >
> > The jumbo frame commit (2fbbd712baf1) depends on the MTU
> > commit (2fbbd712baf1), so adding "Fixes: 2fbbd712baf1" (
> > instead of "Fixes: ca9c54d2d6a5") might make it easier for people
> > to notice and pick up this fix.
> >
> > I'm OK if the patch remains as is. Just wanted to make  sure I
> > understand the issue here.
>=20
> Please update the tag to where the bug was actually first exposed.

Thank Dexuan and Jakub for the suggestions. I will update the tag.

- Haiyang


