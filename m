Return-Path: <linux-hyperv+bounces-1938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3A89CC87
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 21:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A46D281E8C
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 19:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2CA146000;
	Mon,  8 Apr 2024 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="hoYLYLvv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11020003.outbound.protection.outlook.com [52.101.85.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F01EA73;
	Mon,  8 Apr 2024 19:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605340; cv=fail; b=GBH6R9HPQhZ6eEzPlO69V+XhHo0JtHbxWwHqMqtLoaEFS2/buHSepKizGS4mI6K3M/0InIeP2YP2MIXNhSHCQZP/P2J4vuYIjDNyyvA/EYTymzAodbaLZmlvCijVPW3ve1Pfhc3yQEwygqCwxWfoVJeYu5P6JdNC7G/gMJp4MB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605340; c=relaxed/simple;
	bh=cZhyFm/7aF5C8O7z5hL5f20t4eUkcjJDuvpbCkgl15I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WJdSSjaK96uX1HPoYXBQlgllVcgDrbS+zrS9QqIv/4piCq3oOB5UCB3jb4OggVz8yGce5Ja8lAEVNvYGPiHeRoY0oPue4CrIe/rLELP46qs6ecANM1UbsBZnlRcbgKpJ6do4Z66eTm0gubzrfkGIRmsiG91EOzg1nb+6FyMfGsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=hoYLYLvv; arc=fail smtp.client-ip=52.101.85.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cdQol0iXtFzWwfXYJ9A3KkGfG29J/gUFQMetULLtdAdR/jRl3AvKgZU0DFkHXPfjkmAapeAYatUfbn1e02Gt7OggGkJbusEl6rNLSrjjH+VHKVfp0wNGMx4xWLXhcpwSCGzoDHp+xC2lySjGo7HL9oLkXHnizd6stftqhkySz+9P/tebGldm6HPRPJTdQhYlGVGTKE0YXYmgejQMY/DNXZT8MoDBHrPeZQfcXmtfHumu6S+6fXD1Rg3hJ7AT7WS7PgQDS4qOfB0RwBx514J3PD8/43+b0/QWcsqJoBkO4rDADLnWxmCMgBZKupkVPpC7W5NJnY8IDTKf+KudNSp+nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rY9FuIcVgDEp2FPCI2/sIlfuWnxeOsqZW35pvWeprLc=;
 b=A+kW4X8avAqqEqv5T0ZG80WUnXPfN3TYlAXnHpbJSJvofLNcDRttDpQCvUoxXEWN/8JaBR4EfoazwuKt0eOc4gSA+ijFcpkTbFTCWPsuW42a66bYRILZGMox6HgWBZ9euabGMGLAE9eM36WTgPPk4ZwhLWiqRzrB/L1+xs7aHTEoqmkH7jpvFv5JRcJeI2PhqIx1vjma8c4e4lq8VXyFno1YuofpHn+GX3uUVRzJ1B0niKmXwEQpg2lPi0byZB0Pb1RmbBbS9yvZEpcTUa6lGVqXgGNgA/mRRlt5S+UCx0Z7DlR5/qHhpJsrnEKZTyaW/iAe4xfEV+XTuVdCiWjAig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rY9FuIcVgDEp2FPCI2/sIlfuWnxeOsqZW35pvWeprLc=;
 b=hoYLYLvvMi6LeU7hiVAg1Pa6xEQvXVuYsvhGlx7ppO/M720AWFVHXcm0X1QCvEIzmoPmrQn09QAu3Jn8h5TzqbA27TkNPz+10qRbX10LKyhKQ25926IgZQaPvzSVzGfjXK2tCBNWKhHHN72QKe8zdYP3qZddTMrHgYUUvZ6MOi8=
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com (2603:10b6:a03:453::5)
 by CH2PR21MB1527.namprd21.prod.outlook.com (2603:10b6:610:8d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Mon, 8 Apr
 2024 19:42:13 +0000
Received: from SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7]) by SJ1PR21MB3457.namprd21.prod.outlook.com
 ([fe80::70f:687e:92e6:45b7%4]) with mapi id 15.20.7472.007; Mon, 8 Apr 2024
 19:42:13 +0000
From: Long Li <longli@microsoft.com>
To: Erick Archer <erick.archer@outlook.com>, Ajay Sharma
	<sharmaajay@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH v3 2/3] RDMA/mana_ib: Prefer struct_size over open coded
 arithmetic
Thread-Topic: [PATCH v3 2/3] RDMA/mana_ib: Prefer struct_size over open coded
 arithmetic
Thread-Index: AQHaiDlNdYVeA1K4dE2VOPjC0rWojLFeyR3g
Date: Mon, 8 Apr 2024 19:42:13 +0000
Message-ID:
 <SJ1PR21MB3457CFCEF273664F3342A9A4CE002@SJ1PR21MB3457.namprd21.prod.outlook.com>
References: <20240406142337.16241-1-erick.archer@outlook.com>
 <AS8PR02MB72375EB06EE1A84A67BE722E8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
In-Reply-To:
 <AS8PR02MB72375EB06EE1A84A67BE722E8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=182be6ea-a404-46f5-bddc-9fabb0d8686e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-04-08T19:41:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR21MB3457:EE_|CH2PR21MB1527:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XeH6qT6eqvUAF/WSUJmUTcL4Pb9UqUFh9n0iZMCmrHESWKvKx2OaLSyVOXZzDCud9G3sNbpph8Mwlaf+KwDaaWb54Cq/pYLJPa/4N/lAZY8Ggaa81gv4YmiS5oghqVYv7PKorFNBHAmTihsYycNQ/0T5m3zjM42MNhztk8p4jP9E/zHI94bUQeDS05LJpI5uM/hWzs5gvLFiH4avqa2RSqvQ+7x1JZI+Fpc4Z8eraokuWYACqRiAoCXd4ZaFWVr0XoPxZQtfTMypfy45E1kbzepDraBpGuNC0fk4XlWDlbkeMNt+Tjb6zs79VrsM+6xl9XOTrAaBe9xeis5mPm56sMcu9TVUaa0IMUjPP51ftSCuKVQMbofI2QgAM5eSgPF7rT4TwlV8IWeiSi+Cnh7vbIU2PaVN45E0wACZBZMZiGUXfG16l4pNxCvCc0sJUN0f0dbgpNkg/Pi7RJmkCovM25cyNn3vBwEiPSVRs7oayQtjt8wTiWeOSmk1wxdxoNDcD5/7U0KfesfkuBHzbTcpQyWCY87XsRr0TNrbySPR4Ygs/m+5Ara0p8Y89jplmt0IpNz7ydIefBbxQUK4uOl4/9F1dzGfs3zioVZRZpfXGTQwLuUV+Y/C8jqJMyKNtFwbPA7g9LgpUGBjsoU+qBgdaQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR21MB3457.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U7JKNskmN84LAWKXnrnNtFFPWs5V8JPWb9jj0EOndNBl/vLR+vT21o+YnuS/?=
 =?us-ascii?Q?8oz1BtXp4/hJb4u1houTKzON++ksb1sNIGx4dcXWhgnbrOmAw+Gg61CcwEZY?=
 =?us-ascii?Q?2t6vB+oKnVzelGZunsnfCM/bd/vNUORj578qkSx69YivoA4lX3uZzHtRiSjF?=
 =?us-ascii?Q?b5EM/IwvQQq3sJHXdfmhFL/1vHUYwytuWq39X7tDfwckSCpbpkuyL2DcJ5dV?=
 =?us-ascii?Q?li0yFrbkTJu/JaqvDzy0MaG+wUqZFbqlgY4K8qR6LH11E0jXsp3YbMQbqjPx?=
 =?us-ascii?Q?Qn6tIyWvEDJFvJUWZRJ7o+/jIwhg36shHspUbf/zujxoolYrnlkzjCcS2MZY?=
 =?us-ascii?Q?usSXM0XH5Fadb1KPvIMeT74VKtRZjK10JQkL5b8R5lWiu0z1HyVDe0VrAvQP?=
 =?us-ascii?Q?EXEZhMhvb5g4+88qlKPK68rR5G3RSjAv0GVrMzUd0o1x1pvQ4AaoERlIxVOy?=
 =?us-ascii?Q?i8M4LMRggE4RCvwopA7jKQptKZwsBH+ZgUxQnIWRvdWgSatRotQvEaJhPKLv?=
 =?us-ascii?Q?miMQv0ibEWBwJuZJunGNmfzcTSaFsaLrXJfb11OYVr15xFHXIzsF/pK6Dhua?=
 =?us-ascii?Q?OO3NLXd4fOV5tE94rORg3ns86kN99FvU9+4caILGqJRJq2QPzz5NYepb9BlA?=
 =?us-ascii?Q?4QQkdpSPWTlsB0VZmMDk+8T27h+nRaUOC/zV3f6LYaBR+u7fMz/KuHlpZwX1?=
 =?us-ascii?Q?Yt82s4jEkTAgkUXYAmizKEmhNipWOaQCfBTVoln2vaQeShqHV30A8qfipa9L?=
 =?us-ascii?Q?ulZVYWFvBl4ymxTAeeBS4SXoXPfGpxWb66RN1U+L7s1SQ+G41gRTudSPWH8/?=
 =?us-ascii?Q?SUGR3RQxgn+zujXGlyMcVOdn14aJiAst4yF7CHgv9xZJRWWFM3RawKEJUqS0?=
 =?us-ascii?Q?WAF6VFgBclMyxPHNwDy/i+/Diiu8UoUB9kzaFG3sY1Gk3y8ZwMxrNimOEKtj?=
 =?us-ascii?Q?U7aVvyxIo530cGKSEv14JGZqEu0u38etoTniSmLeZwmCzy4ghsYn0BY4eB09?=
 =?us-ascii?Q?aD9bIR5Ti13252436tz8M3wP4l8uaiqUZfLvWJ0Qy5rplW/+xlF+E5VJVNk1?=
 =?us-ascii?Q?jyd6FxWIEaEFDz6tK8FY/m2Ju50g11cGWx0viDIWHxhvVdBecEe5PsHa2D9n?=
 =?us-ascii?Q?00Bxt3yuWSGMGKCHHAeapRT2G0zSIG/0SGDdqdjEvXB7aSI9Y1x7+8pzp5XU?=
 =?us-ascii?Q?Usdi+oWsxkXVr7IKdwsiuIrTrFOBWBtYvvP8EA9quBGO0c3Z5XFRXJ8EbBsw?=
 =?us-ascii?Q?mPrWbgw7xeUBZextTwv9STkCCqTRai7iQEflXbWpLpIKnJrbPtkPuGIKmvo1?=
 =?us-ascii?Q?rTwj8vlneop5vFlEZLenFSI5nbgkc8UC+koQ7Us18v23Nlf5QXvOOHDRhsIv?=
 =?us-ascii?Q?2ckCvhn6dr7C6iPbwe9ykAUkBVjAX0qDAARCBIWrm4TY6EcileflNK62Hkhg?=
 =?us-ascii?Q?5DU5HyAjGcCyZHjO5oaw/vE/ONWWglnePm/j99O+SwwfQly4VWYIfigV274K?=
 =?us-ascii?Q?Du9AyGXExNzhKuoQif3hccSzCakUAEU8uaAa8lbD7ae7AJhSMJ094JhIAp2K?=
 =?us-ascii?Q?b0hBwHgnDxA+0m+LSIB2f4VNFpoV3N1cEDcQwDwG?=
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
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR21MB3457.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85d2088-cd1e-46ce-0e45-08dc5803fd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 19:42:13.7619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qix0SwKPzuMMwuQRvKeZR5Wn9y8I0/wPeikLloFFOdyl7eYDs1thUsDouFQw4lGPA1cL3dD/MkEVSiR7U804cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR21MB1527

> Subject: [PATCH v3 2/3] RDMA/mana_ib: Prefer struct_size over open coded
> arithmetic
>
> This is an effort to get rid of all multiplications from allocation funct=
ions in order to
> prevent integer overflows [1][2].
>
> As the "req" variable is a pointer to "struct mana_cfg_rx_steer_req_v2"
> and this structure ends in a flexible array:
>
> struct mana_cfg_rx_steer_req_v2 {
>       [...]
>         mana_handle_t indir_tab[] __counted_by(num_indir_entries); };
>
> the preferred way in the kernel is to use the struct_size() helper to do =
the
> arithmetic instead of the calculation "size + size * count" in the kzallo=
c() function.
>
> Moreover, use the "offsetof" helper to get the indirect table offset inst=
ead of the
> "sizeof" operator and avoid the open-coded arithmetic in pointers using t=
he new
> flex member. This new structure member also allow us to remove the
> "req_indir_tab" variable since it is no longer needed.
>
> This way, the code is more readable and safer.
>
> This code was detected with the help of Coccinelle, and audited and modif=
ied
> manually.
>
> Link:
> https://www.ker/
> nel.org%2Fdoc%2Fhtml%2Flatest%2Fprocess%2Fdeprecated.html%23open-
> coded-arithmetic-in-allocator-
> arguments&data=3D05%7C02%7Clongli%40microsoft.com%7Cfcf2a410393a429633
> ca08dc56506b01%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C63848
> 0150654917952%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D2zSek
> zsyXsS1s9xw%2FwaSEl3h4s6AeiykFG4KiJLzXOc%3D&reserved=3D0 [1]
> Link:
> https://github.co/
> m%2FKSPP%2Flinux%2Fissues%2F160&data=3D05%7C02%7Clongli%40microsoft.co
> m%7Cfcf2a410393a429633ca08dc56506b01%7C72f988bf86f141af91ab2d7cd01
> 1db47%7C1%7C0%7C638480150654924997%7CUnknown%7CTWFpbGZsb3d8ey
> JWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C
> 0%7C%7C%7C&sdata=3D4pzQWVWVcIaeS07VgXY1I6%2FS%2FEFejUD4qv1D2Ouwf
> pA%3D&reserved=3D0 [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>

Reviewed-by: Long Li <longli@microsoft.com>


