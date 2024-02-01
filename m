Return-Path: <linux-hyperv+bounces-1494-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B693F84514E
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 07:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAD32846F0
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 06:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08B16313D;
	Thu,  1 Feb 2024 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="RCt+umGI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SINPR02CU002.outbound.protection.outlook.com (mail-southeastasiaazon11021006.outbound.protection.outlook.com [52.101.133.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED35FB9C;
	Thu,  1 Feb 2024 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.133.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706768264; cv=fail; b=ZCPY9DPONDIa/BSdSks5Kz+zyfA8V0JaOgEoBQaqHl8ch8GFVQHyuqt2SaxR3PE+hq7ua/7KZBVey7tG5PECogynZ9629LPSy6te4/aVpxtlIlzBeOjHTNfHwdYVU32iMQufdFDhwuCRd/lg+4ov32NCJTNfHvuUfSTHPY21nIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706768264; c=relaxed/simple;
	bh=+VHP6lqWU0kAm4W+2l+fwCD039kTHr9WCOlyqL0lqq8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qia9ed861LTxVU+MMiPK+jwyxb24mYGn1iAVaXRfJ4b6Wl/SqDs2R9KL8weSTpzUXPNdvDPdlvawths8T2s0wlwXXMDed5lSTkOxaEfVMjAX7fQl4I3cWyWBro64Z2mKpWki+fv4h3crpES9ANXA5LVS4+wKGb03QfvhkstaK5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=RCt+umGI; arc=fail smtp.client-ip=52.101.133.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/emlYBiCQ0y/JVSad4Yon0fB+kZcMkPLAoYOEuU+0j3uG4SQLjKoX+3tQjIlqkGL1RcJJoV2SgAziV1sjwRTHm2nrSqTsu1jfR8K7dF56b9TuqtBceEGNuxjlM4zyzBQ9E46zB/JHmThd47fh/VD1BnqFMyPgBZtnz+1iW/lYyRL9sztXj0dSzPbucKXXtLhpnZtyHYWuxDXPGkqDq1lT2yECSmAiy9wqJGGdKES8XhnHa9f7CdxOZohi98uSpdy1YQ1ucaaDRtY3pBRIq6bObZSlk9OLO0f6XRYZk+o6RYDfv4s1uClw/Euq0bMHkk8o/7PGtMg5YtuquVA10+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VHP6lqWU0kAm4W+2l+fwCD039kTHr9WCOlyqL0lqq8=;
 b=RDFxlQhDXmafW6MiMwj7XVEIFnYCHGg926lzR2nB5DkVAK+pYwZBTguImEbpMEtMkK51JqG3kjzIAk6F211WbmJtDupUwMVT9EWJhz0x55824DnmV6/Y7Epi3bFz2LYxeIwVzN490PY/5/xJhv/2/w71GCx1a1Jq54UgtRx5prcrCmbRKYIx0B+1fRLoK9BULBWWgnC3a5ujcsBilS4PcEpoB7LyIyPZP9Myvyguf5+yomKgc6QVfTdxOHAYcDMBbufa8WZqo62Te/u3+WO6PFb99+GL6pOjbNkCFT+MpAwzxhaMC1LhGlQuTT5FxsMgmPzZxD5MQ0Z7Ngd1OAcsJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VHP6lqWU0kAm4W+2l+fwCD039kTHr9WCOlyqL0lqq8=;
 b=RCt+umGIu1Cg0gSIq2nFi3o5s+n6tcTPn5V61cP52KC3FnMqdsuKpiD7g/kIQ0yFiBo7rACj860R8ZCBWUrDWsoZVPf4Hua2kB8dJ/XdnT3NyNnL8mXG2DDUvDa6DL2/P8u/2YenXSLOHQH4VwQtGJq1NqR2scWNnm85cJEOkHc=
Received: from KL1P15301MB0799.APCP153.PROD.OUTLOOK.COM (2603:1096:820:b1::7)
 by PUZP153MB0634.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Thu, 1 Feb
 2024 06:17:37 +0000
Received: from KL1P15301MB0799.APCP153.PROD.OUTLOOK.COM
 ([fe80::3afb:679f:e653:5c2b]) by KL1P15301MB0799.APCP153.PROD.OUTLOOK.COM
 ([fe80::3afb:679f:e653:5c2b%5]) with mapi id 15.20.7249.016; Thu, 1 Feb 2024
 06:17:37 +0000
From: Shradha Gupta <shradhagupta@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [EXTERNAL] Re: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaVAwjmntiXunnhEuM1B/1uGjqrrD0o7UAgABgxOA=
Date: Thu, 1 Feb 2024 06:17:36 +0000
Message-ID:
 <KL1P15301MB079998B4D03095FB6DCCBC59D3432@KL1P15301MB0799.APCP153.PROD.OUTLOOK.COM>
References:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240130182914.25df5128@kernel.org>
	<20240131060957.GA15733@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240131163048.574707f2@kernel.org>
In-Reply-To: <20240131163048.574707f2@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7eab432d-8886-41f0-8b44-2e0393cb46ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-02-01T06:17:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1P15301MB0799:EE_|PUZP153MB0634:EE_
x-ms-office365-filtering-correlation-id: f6dc6aae-00e3-4e34-1a99-08dc22ed7c09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U7L5JeVgk1ts7jC9sZyamKgCCK08l+KXNM0tspMZznbT0JEEEygX4Ep7hHAUvbBsOQ+iMCn4PAHWwEuPPFDjm/D1KDeXBXbJmJpW7Enor1cUC8NbBWVQovEd9JDE7W1I6lcfRZNIMXKTqUVB7gA0Pxl82bbRzkUy8mp4yQgTRvXYBLIPCsztzihMkf5l6bQTpVEgzftd4XQsb1Fyrj0KIgm6VBs67+lJqCw6BZGsRXSg4B3KjWwn8BZXxwZa0PL9GD7xGMDhBKuOJqHOCoCig3Cv76Y3ZxPoOFIsNCIWJ/gLmpbtq4BX3yKxzsRKMG7xiBsUroEQtZkSKj3AkBKbupMlN5ZAYsff71vQu+kBeZTQ8bPTGdrvJtGq9lRSjSQ/1f+DL4PSb88WZ1R2XbgEWQzpu5ZuWxsflWFtBKf6DW7VBFbjj19EYfema42HxSw2e1+DqJacr2GOrYssJqqYKkr+n9PO0b+75Zk1rWD3RqXaMi3K4+H2usIHxr0NjXkiblCHdS3hbdy1XdVnVLIP6AmS1vmPAxMlDsuwkqqghCUgcIC2o2pGVYbtRpuyCBid3rj/8wn9oLGcOeXxzhid5dD0v0NCfCCANGySAs04E6eNWDkVnqveU5bdrbX6Rwpl39LXXrVQ3k+PxoDXSVSwvKbXWr/MWCPwc3/LpaZHh0Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1P15301MB0799.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(9686003)(38100700002)(122000001)(8676002)(52536014)(8936002)(5660300002)(4326008)(8990500004)(7416002)(53546011)(2906002)(10290500003)(478600001)(6506007)(7696005)(54906003)(64756008)(66446008)(66476007)(66556008)(71200400001)(66946007)(76116006)(316002)(110136005)(38070700009)(82960400001)(86362001)(33656002)(82950400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yYZtXsHu8q+QXvea+8u4IaUDS/yWena2W0zqeFy/O3QyFVq0xp5u4vqUEVOr?=
 =?us-ascii?Q?rgcaY4trYvI7k9HXioyrPc1s5pW3Q/EvMosRj8LCyuwkV8M+InYjjj0s87Go?=
 =?us-ascii?Q?lzVQ43SdhCssOQkTMqMz0gdPkkDzt0JsA7JhNZnZeSAXO8Dvbg89BrV6zXYq?=
 =?us-ascii?Q?DJ74UE/cNVdJX1Y5aww0wuhWGsfvve+edtI3JufDCuAVpf51Wx+SdE2EAlQ6?=
 =?us-ascii?Q?DEiEc8A+l67CTy70RIHGSRQG3uWYl4EhQ00xCpJExfqNxF99E0r2NEHaC+pM?=
 =?us-ascii?Q?S/act4mk5pK0BqLv+jj7W5M4EOe3SCk9w1EPL2WK+NKRkXQuTVIGHo0seMcv?=
 =?us-ascii?Q?czmVC0bVqLYePpoQW56MchI19XAl544FCg3gChGCMvdtEPYVILaGn9gdpb76?=
 =?us-ascii?Q?QwgLFFVYU2rX7OLV+IgW8xtK/WAsS/uaLpNVdU9JauNlniZBeLS7Vm+2GxpW?=
 =?us-ascii?Q?YZNLMdUrBFkQvQfb0PS1Sx3zAZeFrXe/OeA1efYcncJmDxhkt515kJHutcoR?=
 =?us-ascii?Q?bBATyH8NBzfBGm1pg0oN0iJ3l12ddod/g1MbLhYMhTgJy4vNmjgp7RqoqTxD?=
 =?us-ascii?Q?UTV8J/UUdICKjxTCjhftWBbkGX0sy3RCHtjqc4g5RMF4z70FhJ+Mtfi3hfrH?=
 =?us-ascii?Q?Q8oQj12eGBhVilvI+o7yWcCPMaYwWE1/vpkmzqCfDSRskz0n8PNxzafZHw+a?=
 =?us-ascii?Q?b0arGRB3SwCUBJhm3qS8+RSeCC3sFYbF/beMZwFPJJrcc9ZcPvbc/IDdJWJL?=
 =?us-ascii?Q?o/mm/jimvQ9FrP9hXkYbKXng1GutLmGhtm4t7g//717XDepk36y516bUvMPK?=
 =?us-ascii?Q?peMP45BbbVJCl0YQylvS2cSgEkT5Mfhe3oSy2CUctScq3yPvO1A50rsYplmE?=
 =?us-ascii?Q?T1s724/UzCr/63ZTt7Q2dlqzAf7f/yZNVkUQZvEgNVbLjcgw1gF/+8qrCIz/?=
 =?us-ascii?Q?tZlE9zrvsLni72VWYdYp0bd1X+qpStjsHwGiXXBpvxQAiv3fgeb6JaMH1EqF?=
 =?us-ascii?Q?CgTUN3sdFpnLRE8rU4SLD4TR26OUt0s837pFy5EDQd9VuD2yokzR3GL8y6tN?=
 =?us-ascii?Q?6Hppgq8FwVl+WfFov66tQdiKNmR+khtvEcJ53JXBQz8ItQiSKssWyt+IWEBl?=
 =?us-ascii?Q?KmwnR/KsortWF9WgaFbyTcc2d6aYbqU5JNaPSLaInuUYvx2eTrk5FibXKGgB?=
 =?us-ascii?Q?Fkbe3HMREj4cn+KNEb/RGSI9ABzSxO6qYXiAqSZDNMD5YED150NOca8TulwQ?=
 =?us-ascii?Q?1mivwaUEzTXtwJ6cW/GxIjI0HHZo2EnwZmVpc8ulFeGQy4RsPSIBTOCxAO/q?=
 =?us-ascii?Q?IaIFzhvtZEttUED5wLI3HLBhJ8vf7mpMzimUtDAqNpoysOVxo9I1ad7u+zBG?=
 =?us-ascii?Q?PxDgOetMztVJcNTmK3yhpxN6biOBnGd51Sf/lGAFp/5FIqf/O7MKbjVfW3yB?=
 =?us-ascii?Q?fWDFmKhOIP3COwdYu/C9dIXY2mhbYxQO4PIis1hTvG1L8TXij+l8EcoihVR4?=
 =?us-ascii?Q?YGHmXiBWk8xBPnMsHwkbCeadGprnZTWhzncLQGBcJffjfMupMlGqad9NtGEE?=
 =?us-ascii?Q?dMFVQWkqVmXHeuk4DUJblvclcZXKvPMUXjKBgH5h?=
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
X-MS-Exchange-CrossTenant-AuthSource: KL1P15301MB0799.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dc6aae-00e3-4e34-1a99-08dc22ed7c09
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 06:17:36.3052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFGMtiLOhC+lTVOhMZNP7Uej/veUxI9s+mO49Bt/77SgZN9422RjlzY8QH4u7B0lC80vPLC2MpcBBd4rG1gjBHRKlzFgqyceqVbuTyGP/NU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZP153MB0634

I'll fix this and resend. Thanks

Regards,
Shradha

-----Original Message-----
From: Jakub Kicinski <kuba@kernel.org>=20
Sent: Thursday, February 1, 2024 6:01 AM
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.co=
m>; Wei Liu <wei.liu@kernel.org>; Dexuan Cui <decui@microsoft.com>; David S=
. Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo A=
beni <pabeni@redhat.com>; Wojciech Drewek <wojciech.drewek@intel.com>; linu=
x-hyperv@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.=
org; Shradha Gupta <shradhagupta@microsoft.com>; stable@vger.kernel.org
Subject: [EXTERNAL] Re: [PATCH] hv_netvsc:Register VF in netvsc_probe if NE=
T_DEVICE_REGISTER missed

On Tue, 30 Jan 2024 22:09:57 -0800 Shradha Gupta wrote:
> This patch applies to net, which is missed in the subject. I will fix=20
> this in the new version of the patch. Thanks


$ git checkout net/main
[...]
$ git am raw
Applying: hv_netvsc:Register VF in netvsc_probe if NET_DEVICE_REGISTER miss=
ed
error: patch failed: drivers/net/hyperv/netvsc_drv.c:42
error: drivers/net/hyperv/netvsc_drv.c: patch does not apply Patch failed a=
t 0001 hv_netvsc:Register VF in netvsc_probe if NET_DEVICE_REGISTER missed
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch When=
 you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

