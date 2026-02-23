Return-Path: <linux-hyperv+bounces-8956-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePYJBWh9nGm6IQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8956-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 17:16:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DE51798CA
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 17:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5FAD30067B2
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 16:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784BE309F00;
	Mon, 23 Feb 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fawBAy7G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020112.outbound.protection.outlook.com [52.101.193.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB4C304BDA;
	Mon, 23 Feb 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863107; cv=fail; b=LMO6Zjkojin6sepgiDcBsdNfZzP64jZ004kOZWJ9vikK5VQYrq2YumXTFbJStOobdOeial3i/VrR0uEsBaAPWxdGMmrX/yDRD2SjVAa2ISQCPw8OvW/SiehMdgYm4Gku2Ybh5gThtjSwruB+n13udHG7BScXFs51ePXQo7kozMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863107; c=relaxed/simple;
	bh=MqKBWc3CkEQJ3pVAVB1fCzDQ5taloHxGt/9DWDC+Gg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UAcWRqT1jHwt6wAl3qWb20P4hhiBleweM4TAW46psizJsROn/AXEw8A0AQJ1LI1oXY0HI7blsZQSjM3/b9NbS5AIT3IUEVxJImn1JlY6UA6r06+DVlAxS/a8BMk46AI9bM2FpN9oUwRlP0MgXdZwMCXmxv+1nYl0uEg8A//bzL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=fawBAy7G; arc=fail smtp.client-ip=52.101.193.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mo+KqWy1esu93BA/D0VkTeuyToIqcobD9UIX9i3rYByMdJpTZablsXXo8ixoYmG86Vjaqfgq9uBU+M1nNrO/pOvoHXpF+m/4k8ZsfmGgACeVEK/Rb9napzAZHNN7PbKAMUb03brrYBPWWJEdVzKVquXBTWGECM89mgsm4lm9D/EJL5IO9mZPoRc40wncl696+Vm/vt1AgZMePwh0S6MFfLNXnrYPJNwH5073N5xWg6shPc7/Frne+0h7g18YqFeupJ2fD9TBmm448NKC1sRuHztBbPY7FC9MOm5F9mW2r1zP+EDjTU4bdi321HrAWn68mTGZhTqlGXtBNnF7WlnVZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqKBWc3CkEQJ3pVAVB1fCzDQ5taloHxGt/9DWDC+Gg4=;
 b=MkHCmaqz6ENrkgrp2JqYaLq1QQtEFAMm815HXg8mbvPqVzc9641LOyYRaSEsIkrRmVr/ia8yKEXaJfpjRltG7lBkJwcSxPyNPNDubTOo6YoUVpvn8aSnjRoZY9gLQajPc1gcNC9tCSz6UISBsZEC6TgaHm6jMXfSOztjwjQqJvRD+f9uWBsdUn5JCa2RdXkXa60unCJk+0ndGPR2kbARYaox8FVrODHSMy0Qqoe7bc+nkdHqoRWz60Oh0dDDJQUHiRTv88iAKKWNfEEpdELotIUnSZotiuNwy5cWBnnmV+KaAZsmmUqj/oymxm7uSnrsF0usdkMD9PW0U6tKJ1Nbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqKBWc3CkEQJ3pVAVB1fCzDQ5taloHxGt/9DWDC+Gg4=;
 b=fawBAy7Gc6nP/27AMT4jv1/gKjAHBqgMgMEI/m022+Zy0k6jHfJozjczJ/vpBnmIsy0vucP8oCb3oprpFr8ijWkMh5MFbiWs4gswWcKwTq8IrfNbowLmtlGcf9ea7NaCC/zP6vBBJxAXEs7CyqD9olJSxeWfPIV0IGDy1K19a58=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA3PR21MB5794.namprd21.prod.outlook.com (2603:10b6:806:499::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.6; Mon, 23 Feb
 2026 16:11:42 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9678.006; Mon, 23 Feb 2026
 16:11:42 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Andrew Lunn <andrew@lunn.ch>, Haiyang Zhang <haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Kory Maincent
 (Dent Project)" <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
 COALESCE_RX_CQE_FRAMES/NSECS parameters
Thread-Topic: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
 COALESCE_RX_CQE_FRAMES/NSECS parameters
Thread-Index: AQHcpEGiDcItgSgzW0KbKcdvetQIAbWQUSMAgAAjafA=
Date: Mon, 23 Feb 2026 16:11:42 +0000
Message-ID:
 <SA3PR21MB3867626519876C32C1CB7EABCA77A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260222212328.736628-1-haiyangz@linux.microsoft.com>
 <6bf21536-569b-49b4-9541-c22a152570fd@lunn.ch>
In-Reply-To: <6bf21536-569b-49b4-9541-c22a152570fd@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7d51cd22-e4d4-4493-a1c8-f6b862db246d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-02-23T16:07:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA3PR21MB5794:EE_
x-ms-office365-filtering-correlation-id: e0d601e5-0499-4be2-ae2e-08de72f63bfc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?f+/dCKg3XlUJnv4LeDo9F7rW1dpEOQuepjCh1wzFrREqfio/0CtNj+rQidp8?=
 =?us-ascii?Q?gQkv54jtt4zM//nflP1SVziLuawsiGS3yf/st7o5XDkZYyc/m4D1DwNS8MXO?=
 =?us-ascii?Q?ZbO943N39FEoac25pVc/cmq2Y662ReIgnD81usHQpWWjcoU0Y6IycYxZQ5PW?=
 =?us-ascii?Q?iECqfCXUOEG+x0iuyP/rViqmzC1GU8GvqQYjiCd93vlNKarcxlftiXdI4nCs?=
 =?us-ascii?Q?8A9nt73rR/ax+gSsQmGg7xiBcBgeEkQAbpF4hAXpml6d9mtk2K4sWB3IKHUV?=
 =?us-ascii?Q?BDvfmOHn8HucPhBqXHe2+1eXPjG97bUDpqo8B2WwT+CedCVt/aRw9yjMnN/5?=
 =?us-ascii?Q?k8DkzpK+sRrPcEl6n8rWwX98rH7DPAf1jWhpXHjOCIRNeU8E0N1NnYrBl4wP?=
 =?us-ascii?Q?UQweomRAes6oDviWgH1fUyxaI8Hxu7KigiI1Sg89wL7DKNoUzYb3/vCfqa/O?=
 =?us-ascii?Q?IauvgYrEGY9M/6DXr2dt4xeCX2WRJ6e2IstacYlIqelddhgVHuA/wndo/62n?=
 =?us-ascii?Q?z+lZldMTVgE4i155HaLpZ/QVcetInnMz+fb+bD9LM+V+53IJkE8g19aPWmWz?=
 =?us-ascii?Q?EbOid8Wc+G448rK/lPNuDx+HInvIAzw69HCEmkqa0q1Om9hpEipHJTr6x6KG?=
 =?us-ascii?Q?2WYA1jYMCm2XzBt+7mvpMHTeHmnkPJ1vqEv5UYwHWhAYjgOT36kX2mfGtye6?=
 =?us-ascii?Q?eDlwuvrh8/9Msg9IFOA/lUMrrGUR8HbUgffNH851g7bctvSPaUFZ2OVX2ZiG?=
 =?us-ascii?Q?UDItdw/2/ZUZgm7wjcjZw9Vet7+/S7wIBxw6arO8sn6OVxJgQATTET+Ap9Se?=
 =?us-ascii?Q?sK2aXBHBdSHnbQsryNO/OJArBvbVF+0D+W4Z3/R0IckUB3YVZaIK80za0pJE?=
 =?us-ascii?Q?NBV86JxPmfE0DCMGN+rr8EguQTvPacgSPzq6Y+6TO9yxf5GYVM3+ytpApBbD?=
 =?us-ascii?Q?BhiC8LVTOj90IHJ6j6bIYXyCoTpBYzsr7zn2sHzJcPkFXcWQKHB+FZCE+nB6?=
 =?us-ascii?Q?n6w3Vrfipu4ZIDlxyDPNrYDuhxIJPrhIviCovYCbWKrDfw/qQPqXLQsD2sZb?=
 =?us-ascii?Q?uXC807PBUJXUqqEJhYLsZWh64fWlWVNCLhfrJCOGTA1J5UnrZcU/QK3XBosH?=
 =?us-ascii?Q?6waUDaBpXBsQSfV7SX8Kwgd9+nwXuU2SuI8GLOKdw/EOgcXsj4CRhtVjy1Zr?=
 =?us-ascii?Q?A0/NWe79pvKQNSfGAItwe1RDvu6CFWL8xFnxfGBUZkx+kWLiCGu1bp+P88ef?=
 =?us-ascii?Q?dXDa15cYFbqWEvcO9jiFbC4Wkbx+0Jn6y46VF1yvok0w0jz7YMeYJEYFy8S2?=
 =?us-ascii?Q?2P0P1sePVGWk5zg7YV9RBZpdCjIYtlvxvp6xlYNnJsR9ig4t3xGh+EFoQDbu?=
 =?us-ascii?Q?4nMlB6czCkLEnfSa3f0lpqA4VA9QLZV/fbj0kux0cnU1rncVmQbKjQRx1vnV?=
 =?us-ascii?Q?6VJ4gESqaTE/CXkJqfnqZI0O2W+em/w0SeANME6SiUYLor1s6Dh6j+NoDWRN?=
 =?us-ascii?Q?tp3t26SqwKUIGt+l3WJBLkAlhWTLvf7K4a6qfkMLuij0sObdV99yMl1oHYq/?=
 =?us-ascii?Q?w7kmtpqpoa9aGsEJPgVpbFEU4iJOUXcWm2uQ0KEEd/9NjU89VydOEKeLlYfU?=
 =?us-ascii?Q?xhGO4fJpXy1+9nwlrPcqlWY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kcOHVlF01ArpPKKO5qAU/WSCUEgK42eoBv8uWe5f0cGYjSIZoYJDtD8FX9P/?=
 =?us-ascii?Q?YWDgqLIBB7VugtrKrVyji7zlQKs0pMtQhAwxw0vdDV1OFjmnUIiTCHQ0ztYK?=
 =?us-ascii?Q?doxtKDILaWEah63ycVAYG3N35Ddbfih0hqPvRUE4/PC1gDFKxt8exXB1opJj?=
 =?us-ascii?Q?0ms7Ef4zVMWZS0FWULX2MU3AWEcfaRlmtQ9kh3j+e3vGeiKwqKYXZYp4Fkav?=
 =?us-ascii?Q?KM5p6PcM4K5C1ospQy0loc5jBwtdRTy2rAtc02P/pVmLoq8KKh8OAs28/BEh?=
 =?us-ascii?Q?xE5eBiB2RIc+TXglXdViPP5MEIkeaCHSss+PnrTfHiQ51UYFZRwGOv2cifed?=
 =?us-ascii?Q?4Rpvn0qAVosf9j7BxHM63pm6y6Y+xIQK09INKdrWj/XzSmhAtzRy/x/+IgTH?=
 =?us-ascii?Q?R2AVRgIoGN94BB+1SPqGSyy8ZMzKepauLp1UQFppFChOM0Llz/BsEP9fyLDD?=
 =?us-ascii?Q?8se5J2MNW5FSFS3fdw/ouc3wfyfasMe9bhjEms+etubEl6SEEdPP2QdoFk8X?=
 =?us-ascii?Q?os3tQwqAnSZmuKSuV3f9LGPeyw5dLIqFGARMr4Hlu6IOKyNKoa0UIZaWt8QT?=
 =?us-ascii?Q?RNERrEzxDnJFC2PE/Q9TyhSZVOxIhIhn3ioCpNPaBmOPdIC/Ma1s63Lxb2VD?=
 =?us-ascii?Q?c8q1NTZ/XQTZcd3MS9HCFDtBB3wOLL1dh4KTUoa7Zjr5HBaqqh/j1+JCa4e0?=
 =?us-ascii?Q?IKEyP6NPBqjCbS4eW5sxyeuQT5oFj/B+fpSZUKaZJDvkhHPrk/KA7CIuVm50?=
 =?us-ascii?Q?msu1cv2pRRvbJEQImlLytx6vxOh1P/Obv9rTeWKWXPv6tT0L4h2qxGS9eIrA?=
 =?us-ascii?Q?GZoGRPmFpKXzpj2nJGBlbTUBQByCuaGD+EazW+9yDtzcuXNBMMGkg8PReoJS?=
 =?us-ascii?Q?aKOaILbSYeXVDaZ+gpNhnAXGxGfbPV7+6Ov7LH+76obWlPgS1bbqISzM5k0N?=
 =?us-ascii?Q?ZN69U0q/xDQmgO2Xf2M2jwgxtU1WXyrupqq8kz8Ay8QERFkd64C0fZXI5Bw7?=
 =?us-ascii?Q?DDKBZKU3I8P6XntEPhwQJtJqlFQ2RnWMf/iOvuaFAqBzs94R4MU9FlimljMj?=
 =?us-ascii?Q?4HIRUTMj/x9Uj16aeIhr7vpZNW8phsw4IF15kAjzGQYMexVVtfwodeQglIR3?=
 =?us-ascii?Q?n3677cG1g7tfHredO+ztizpgqYK0rTQ1RPAJdto9tucNseeS5CuBgGJBVAGo?=
 =?us-ascii?Q?jvNZLi4BoizjOI1T1gacdphKopQUmx1LXzi+JmRwT21Uk4uoKPu4yel76eIp?=
 =?us-ascii?Q?z7xVNTMkX+sWn3CU0QDQ7/6X6LkjRD51YzYCU1nMU6P8D8K1BZnqk2bHuE/5?=
 =?us-ascii?Q?NmKLzmae22sOu2mrIuVT0bP0OzwgEsFQb8MXAeGDpNZyl7tVF08z6aOrbCpr?=
 =?us-ascii?Q?7Qauso5muzbuIBfpwi6wqjiU/6Qas1AZgPWa3pwZXEUbU8r2nqre9sKN62BS?=
 =?us-ascii?Q?HF0Dr+BblHpZD1fGfUiPje+Hgq8e5NhnXyD9BBCbfdcmOrsUlKG+D+bBlZy5?=
 =?us-ascii?Q?3rcdWaCOtk/cJ4CrnB/Dw+QoS5GtQ6S1/y2kdfKnfuE50idpdweaGq+0K2oV?=
 =?us-ascii?Q?18mHESTMEn0s/OpImU3CWfzjoBd0GHWB4s9DwxT0xXwEfcZnifTecS2dgMcB?=
 =?us-ascii?Q?M5Akn01dJGSpUb1N0RfuCJz5n3ObvZ/UjQ0r60bnLdFW4dZkA6soJnDyaE6C?=
 =?us-ascii?Q?Ow11stDEIc+r4/UBopl3LORVl4bIEUs0yfs8Qa225RaYG8Ps7hPxyKiRZ2SS?=
 =?us-ascii?Q?8tbiPrs4Xw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA3PR21MB3867.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d601e5-0499-4be2-ae2e-08de72f63bfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 16:11:42.7081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F878N1Qu8qRqXclpicJEZsu5DINqjuOuZvWTCJTczDK9Q91i901ivMo43SaqQUcaWerA8WnYDGKEwO9ivpH5SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5794
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8956-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,bootlin.com,nvidia.com,pengutronix.de,linux.dev,microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 67DE51798CA
X-Rspamd-Action: no action



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, February 23, 2026 9:01 AM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Jakub Kicinski
> <kuba@kernel.org>; Donald Hunter <donald.hunter@gmail.com>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Paolo
> Abeni <pabeni@redhat.com>; Simon Horman <horms@kernel.org>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Kory
> Maincent (Dent Project) <kory.maincent@bootlin.com>; Gal Pressman
> <gal@nvidia.com>; Oleksij Rempel <o.rempel@pengutronix.de>; Vadim
> Fedorenko <vadim.fedorenko@linux.dev>; linux-kernel@vger.kernel.org;
> linux-doc@vger.kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Paul
> Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next] net: ethtool: add
> COALESCE_RX_CQE_FRAMES/NSECS parameters
>=20
> On Sun, Feb 22, 2026 at 01:23:17PM -0800, Haiyang Zhang wrote:
> > From: Haiyang Zhang <haiyangz@microsoft.com>
> >
> > Add two parameters for drivers supporting Rx CQE Coalescing.
> >
> > ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> > Maximum number of frames that can be coalesced into a CQE.
> >
> > ETHTOOL_A_COALESCE_RX_CQE_NSECS:
> > Time out value in nanoseconds after the first packet arrival in a
> > coalesced CQE to be sent.
>=20
> A new API needs a user. A kAPI especially needs a user. Please add
> support to at least one driver.

Sure, next time I will include MANA driver patches using this kAPI
in the same series. The MANA HW/FW API is still being worked on by
other teams.

Thanks,
- Haiyang

