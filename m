Return-Path: <linux-hyperv+bounces-821-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079787E6C85
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 15:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F94EB20B23
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 14:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B75134C2;
	Thu,  9 Nov 2023 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hPN+jFbj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFB20E6;
	Thu,  9 Nov 2023 14:39:10 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020003.outbound.protection.outlook.com [52.101.61.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988E8184;
	Thu,  9 Nov 2023 06:39:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO3UNJmYD3OmcJ9GBnimOXy8dLe+ulPI7uFC+mva28qHzf3G1qBWRblqjV89d14aSCbs9G7IwH0Fr1/qEC6ZrzqBN7DzVTTiPz+GX8SyGgcDd8ZP0mAn3Phx9ZQqzZcfdbfm8TWOMG2IpaRflBkFRrst2hM6ynNnN925S0y9wTyH3Hq+l6XQXnswW7Vb+XtfOlyRFMEetWrjgS8wm2jUPM0OIesDqg4Xku+4Oty6R/LNYTRjiKWkPPGdg03oPuWC5YDlMMOu43kqwPUNnesfVqGKWJ4oYCIqpRlYr5+snIU1V/qFzTL/F1dEZYeMHxV+uBCRiA7hZcNFCFycBnnKVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk1pXClMJvmJ0uk15aNZWD3cbRHB+qLBqqjp/RopdXc=;
 b=JZlpSeeUY5xDuruNn0eVCqVdFjjDToYMp6LZOjavkZmmy39glFQHG3WjlTtHTkRwG8WT5A265Z2bWrOiYAs3RDapZv6NzEp6EGcAoNBmSxID2WyN2LTuozuw2WtpZPyAl6HONrO2XyuEJaB+rbHQXBBiQgLwSp7p7wh+R87Wl3tmSwgQ6CAXYFK9BW4jnm8gxUe1+c/3GNnmX9pRPG05JqbmBSwiegSO59qHIEqwWYTFXigqId2bdOGC+3fa1Cjus5ptkuCg7VGi+pz09UB8fM5BXsEewI1Zlb8xCPPyQ2+ZAAP8k9Y3Gyx8iIzh1cvXWlTPdZgayjOIuaGJaMOnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk1pXClMJvmJ0uk15aNZWD3cbRHB+qLBqqjp/RopdXc=;
 b=hPN+jFbj1xbSSvWeGLJg9+GC2791dT98WhbjCrw7f6FfbGMPQVhHmXtPTfR9ML7325BaQvEnf16MovXkgxm5UNsb+AUZ54k/KkQwB/4H7X2U430azdYwoPV3Eqm70wdwS732wR9IlH43BI1RExIYR3eqLxRSHMKOiqZJ9W3jW9o=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by CY5PR21MB3543.namprd21.prod.outlook.com (2603:10b6:930:c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.9; Thu, 9 Nov
 2023 14:39:06 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::4cdf:6519:4a36:698b]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::4cdf:6519:4a36:698b%6]) with mapi id 15.20.7002.006; Thu, 9 Nov 2023
 14:39:05 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v3, 2/2] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Thread-Topic: [PATCH net,v3, 2/2] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Thread-Index: AQHaEb6Ik37YP3oeSEOL/cl9SKSQv7BxRMAAgADMiKA=
Date: Thu, 9 Nov 2023 14:39:05 +0000
Message-ID:
 <PH7PR21MB3116D65E4546544628C61EF8CAAFA@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1699391132-30317-1-git-send-email-haiyangz@microsoft.com>
	<1699391132-30317-3-git-send-email-haiyangz@microsoft.com>
 <20231108182618.09ef4dfe@kernel.org>
In-Reply-To: <20231108182618.09ef4dfe@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8f88658b-b65a-471b-94fa-ca9f5d4e9d8d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-09T14:38:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|CY5PR21MB3543:EE_
x-ms-office365-filtering-correlation-id: c98e352a-78a4-413b-c7aa-08dbe1319fd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 81Cuhk7iDDj7bt9HPOHiC1hoHq5bsfi9CMleTvMqbbHgXUTpVTPDHOCepuqaxjaU21IunXDramW9BffvixD/ovuMEtDv6D0Po4CQ6ouS63DtdAVJhfy500fLgcdPfJkoC3sup/QFxZRooDeBgS6PFV0YloznB9mdc4uR2ebo5ogecBfRfwuHMezggZqiO+FcUHwhENC7X4oVotUmoCbSv+SSplGcnSvkOD/TsZQbuLiXbf3k46Ew+B2AbKxXVyUTb3QVXnAQgLBgvbYO891IYydLvOsy05TC09rg2OKWBPHc9A4nwfsML2rfB0YUNmV5OqacTfC7V90XdqXlS32J6u4napLs0eM2nQ+GVGD+BdCsVFTrEf+4VnuP3ZuHefITX07Tykaf43o42KLmpUY2YEYcbRmEtyVDG6T5xaRbFMn2LX5e9SY1lv/O6Th0JAlnrTewMyFRFz4nRxik/PYggDTrdDv1zVqyNxswpI0gdO4eN7P2BDNedaogyt+8SzXR/7V5VJUqtNFGSgC6byrDVmoqVwNhxMbC4VN6IlETv9Wy2XK/48TnZmMH1uuJ8BRbcF6RWr4NzRkSlozKwypX6yHQHk3sQRK0caIQvPppHdjuV+UpkAeOL8L+0oGA8fhcX9++cfn3BQ8jh1YUJrg+z+IUa5a9ArPnVmG5pyt0NFA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(8990500004)(83380400001)(38100700002)(122000001)(478600001)(10290500003)(6506007)(7696005)(76116006)(71200400001)(53546011)(26005)(64756008)(54906003)(6916009)(316002)(9686003)(66556008)(66476007)(66946007)(66446008)(2906002)(52536014)(33656002)(82950400001)(82960400001)(8676002)(8936002)(86362001)(4326008)(38070700009)(5660300002)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fFM9WLRQotP1WezGzcWxheJGTzZyWaMhfk1SuL8I0kNhFdUqBGwXLGWTluwX?=
 =?us-ascii?Q?+fvBC3PrQAMfJHpin5utYTlFytqUn0x1LqAJTSNXx0LcE755xPzKXE1vAWe+?=
 =?us-ascii?Q?yrLvZPUyE7lvI+KuZcn2PjfhwhbLy/nUGNA0Coo5SNxk100AwXVRMQd98+RN?=
 =?us-ascii?Q?49ejtYTXJYe6exBJPn00blKLJ4pebzuR5HI1+9AbVF2kRxHPyhO+C6pDGoi9?=
 =?us-ascii?Q?QllIwLpRcZwitQlzozDusjhmpQkPhQWYJGKwRz+OCzEJDEnp7H128IGcqGLp?=
 =?us-ascii?Q?UNR5DAUfhPg559gY2oXR7vomugaX/gIg9pxSptw/jBxXJ0q4GxxznBjJtWId?=
 =?us-ascii?Q?MmVCjHNzFQT4PcNWXFRPcErHo90fZ/5tduaXat8s+QAq9s6+oOMAQRcw3fKz?=
 =?us-ascii?Q?aEAEdOr6LIha1KYLM1VCetcnQc0tgpBNf+Zmn/lcYetk1UBgkef9/G1sXZgv?=
 =?us-ascii?Q?rzj70Lz/2IQ8bf2cq4ZKQ7mX15OWe0Dp+9e17L4CaEIdSOkd1ydAg5pqpoSJ?=
 =?us-ascii?Q?8qgN7i8AK9vEETRg3xOUADKra6OJnWPfQCrSCFRfTv71NTmpSq5M0IAk4k9l?=
 =?us-ascii?Q?wTZyMTtF+/ef9kc0dvDZBm+1CEzUTwdNdHyEoABMQU1UE1tnsfHPpO3bNH3n?=
 =?us-ascii?Q?yMtBLJWhjydKZemXpPq2hkYZMjsLsFalftX/3mcU9gkMbso47i3/Hkq3kCF7?=
 =?us-ascii?Q?HqRHjzSCTBWUTidQalcXW/rthyypHjHELO8fn+pheIfAgFdCWBM9HPEKuH3X?=
 =?us-ascii?Q?cw0SHAwLBcVcRZpucYhba+d84lILabGhPTqrukpUEsSdSKzHHZ1fdwLTeE42?=
 =?us-ascii?Q?6h7ohz5vbMzArgLOLyC9mJ+xt9yx9jms0uJrfnxMXdLF5/4OekCmJOf70/em?=
 =?us-ascii?Q?D0jyditbD3fZ2j3amy8+HNcHj8MapxIweCzVXMvyopwl6ooIfVdOF7ZkYtfb?=
 =?us-ascii?Q?rnBYbdesO2PhjhAJUrUWJH9syGFqJJxDOCQQJZEOVwFDDL0t2Rd9lCsRYkO2?=
 =?us-ascii?Q?331wvqJGrMm5ezcwLMhvvqOxwtNyTuHkejF+134m45hr1WXkLoxSo7uv7HXx?=
 =?us-ascii?Q?s/NIM3GJuZz4wppor8jmxOPbLY31Tscr9WfUnR1aGass+E/Gop643SpYPGbL?=
 =?us-ascii?Q?22dFuMnv6HDvtE/SCntdIGWovzLNGCljK66WaucZuLr6s1TeIOty4tOwtMO8?=
 =?us-ascii?Q?KlQ3N0QbuQsZ6/juS9SLBT4Mli1B/yW2Xhgq3iPhAcQvjNvofVn72xSlZegq?=
 =?us-ascii?Q?Jc3eBf90VlTDiI5/u9Y5DdP7dGf6n8L/9u7K6O7a8TOYRCy583i7ZaiojlP/?=
 =?us-ascii?Q?lCETg2QNdFbZI+UEUC3EMl0UZ5/6urvOB5v7VXlZ/uLecdGb28k3BlL7Jzpq?=
 =?us-ascii?Q?rFjcqWfUj6Kf/gPwMWTp1zQjZE6BXzgP228RbFSTKXu92CRRX8mc4hrf693Y?=
 =?us-ascii?Q?WZxOGUE+dFohFTdlcZ03c9jvWpGyXmwVx9+5BDHQK8JqaMeshBmscdUFCVYm?=
 =?us-ascii?Q?8b/puHAirm6T4W+RcvwkFM0Z+fY+67sO8N1hZje5WIjJmPwX/B6ebgVgjTgs?=
 =?us-ascii?Q?AuRKtkZ+MBOvUjOZVj7BZ8PK6T9ibyQp0BJpv5u3?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98e352a-78a4-413b-c7aa-08dbe1319fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 14:39:05.3698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: apVft613i4JkN4B4gXcP/RQcCNT6K3ja88Vtk2BcchKYbgS9xTlF2Zsl5x8uny8UmUQr6nvH9kpme3m2ERhrkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3543



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, November 8, 2023 9:26 PM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; edumazet@google.com; pabeni@redhat.com;
> davem@davemloft.net; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH net,v3, 2/2] hv_netvsc: Fix race of
> register_netdevice_notifier and VF register
>=20
> On Tue,  7 Nov 2023 13:05:32 -0800 Haiyang Zhang wrote:
> > If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
> > but NETDEV_POST_INIT is not.
>=20
> But Long Li sent the patch which starts to use POST_INIT against
> the net-next tree. If we apply this to net and Long Li's patch to
> net-next one release will have half of the fixes.
>=20
> I think that you should add Long Li's patch to this series. That'd
> limit the confusion and git preserves authorship of the changes, so
> neither of you will loose the credit.

Will do.

Thanks,
- Haiyang

