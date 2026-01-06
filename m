Return-Path: <linux-hyperv+bounces-8168-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3665CFB37A
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 23:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FCD63041A66
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 22:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331B72DA775;
	Tue,  6 Jan 2026 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SBTGA8uR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11022091.outbound.protection.outlook.com [40.93.195.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448E2D8379;
	Tue,  6 Jan 2026 22:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767737408; cv=fail; b=KUoH+IzLEGeEG5N2ZFnGe9tkMB9fMwTZn+4EHopesAXDN0Ne9VhuEAgtqIErIPnGbHRzQnxcf6LiVvAHbUQSqJUe9N0mX6K8jspkjRbUoG+sWVRSoSF/cNSQ2Y0nnqvdWpm8Usn0PN5IALKQOe+5V+r1Oq4imOsRHBexSNmstTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767737408; c=relaxed/simple;
	bh=+Czzp5GWTahvGq10QX8j7emHdxj3YQa5NsI7N9reHGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=thbba3KnsXNihDRAzeIGWXy2D/w7y02CLey4cBsyMkyF9MpCopPCXB0IoCvNJcNPjnCW7X3zfYTYlUhIbNomAju5HCgrgGd69QWPBAHKXQWnfqaHKwyRaZOinNTCKOPQmRnveGFUp6osgQdg77BT4AKfImAYPb9X95xRGx/iR2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=SBTGA8uR; arc=fail smtp.client-ip=40.93.195.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JDU78qnV1nz71jsYo0FZXu1NLde3hpxXVKd5mtudDLilcy4xcSVVXy5+zmv9zQpYT07oRDNQ8uYlqqvzzfGqfipl0xktFYSC9u9pZBnl0P37o9r8uia6EwSlSnAfxH5lyffdM2WPZ4BgImt0K+O392D+FnZ32pKbYObfaQ9TJ+Yafa8UrBVcFT8uuaqvb4lKgiFhOIBvJgcDlSXNTXAwFHtORYzS+9PzbHUhvX1buR1dHGFeilOICebIoZqy2AuaLIYEOXR3QA0S/jkQbn8Uf6h6JqOWWtdtzYpdg3hhw41nhAy6YrObqVtZlZfkzQS1drCaZveg39rZID04J3Whhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxoyQ50v8lSqERluAHyr95yOXhRviwuW5mYjX4J7+AY=;
 b=lPaxGXd3wbCHwlEIOPo4P71VdSM7rznFfPwhN0b1rQVFbImJ08oCUShHCwfnuULNncuc0Z6Dq+Ir0UYn9ntQDpoi6SbCewxVQDDFUv/SLXLtmHfkpF7jUfMGqPivnkoaAxef56aa2sPsvT20bHOYTVxthQwL9ziKrN4WP02cy2w58Zk2RgwUwzq/Aw0QXBPqCJBXBOM9zrjDCOMwvmiyZUX1MhnFvuSi/R8ENXXZEkXl5I9YhNULEMFqHL0KeqYvD63UFRmr1MIZLJPlhacWfsd4ETuvg2B5AiQq919kyVrN1KFy8N3Fc884vxETSAyV20cF3p+GcoVkwdFSdWX+bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxoyQ50v8lSqERluAHyr95yOXhRviwuW5mYjX4J7+AY=;
 b=SBTGA8uR+WO0Svgc0gxej9szO2/uhFNKIRSdgimBrSJ8xG+ah9c/69zRq7TAg2NgepvUbAX2oE+X4WRWjMPS6XTZX0El6msC+HYjw5q+YwnZdSWVAGo/UbFaLkMoJ5D4I+wT7EiAAotcZejolLTx1kDzQuD8vhg0keNNrIAdnLc=
Received: from DS3PR21MB5735.namprd21.prod.outlook.com (2603:10b6:8:2e0::20)
 by DS2PR21MB4751.namprd21.prod.outlook.com (2603:10b6:8:2bb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Tue, 6 Jan
 2026 22:10:03 +0000
Received: from DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925]) by DS3PR21MB5735.namprd21.prod.outlook.com
 ([fe80::a3f4:6107:de7c:5925%3]) with mapi id 15.20.9520.000; Tue, 6 Jan 2026
 22:10:03 +0000
From: Long Li <longli@microsoft.com>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Erni Sri Satya Vennela
	<ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
CC: Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [PATCH V2,net-next, 2/2] net: mana: Add ethtool counters for RX
 CQEs in coalesced type
Thread-Topic: [PATCH V2,net-next, 2/2] net: mana: Add ethtool counters for RX
 CQEs in coalesced type
Thread-Index: AQHcf02viGc0+WNTaUaKdVMHGy0X6rVFs7ZQ
Date: Tue, 6 Jan 2026 22:10:03 +0000
Message-ID:
 <DS3PR21MB57355253303502B93595FA36CE87A@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1767732407-12389-1-git-send-email-haiyangz@linux.microsoft.com>
 <1767732407-12389-3-git-send-email-haiyangz@linux.microsoft.com>
In-Reply-To: <1767732407-12389-3-git-send-email-haiyangz@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=60a8de2e-f32f-43e7-adad-0a9b52bfca0a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-06T22:09:43Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS3PR21MB5735:EE_|DS2PR21MB4751:EE_
x-ms-office365-filtering-correlation-id: 82ef0f27-ea2a-473d-7530-08de4d705780
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WB+GJf6e0NL4KyrVbpCZSterDV38HFBIKFha9yFzT60jRhgR7/Ks6AG84sYQ?=
 =?us-ascii?Q?bgTp50b6gijGyDGK2eu7Gv9nHy65XeTYtR7mVirCJwSRb4gtygD71t9Gasvj?=
 =?us-ascii?Q?qHqgZHYHXEPWQVprXSHLt3WwwYneY84IBdU9J8TB7nvfuz2Zr76bS4oQqrbz?=
 =?us-ascii?Q?Ixbn/xYdvP5aPdTFeBDwIXS4OkG/aMCskLSCGiF1+ua8UZfBrNFYC05/Zxj+?=
 =?us-ascii?Q?s1ggIG4GzUID0IkiX1HIW0YwTB16wFi6xplnJ6uGolim1xNNQT4QTBw8q9Wa?=
 =?us-ascii?Q?k/9iP68R+eIkYyIm6TTrSgyDAuv9gCm5i5g07YjoOhSxqpsqZ17iKXkvDIoz?=
 =?us-ascii?Q?53pHzX+iUxK7AdPXz2WHhKofU3l2bqyLqTIKLDy2k/7vRfA7I5wRwHwSttUN?=
 =?us-ascii?Q?F+vJhQB0HYH8x8nwmxPnIRbWU7q5PFjnkhMwu8PbI2MS65NxHtGt6pPMjmEY?=
 =?us-ascii?Q?HfI/9qpACWfCyrVV+4HSqU5FmGVOwhxMWEOPd6Zm3kO7UQraZ5u9+rb5Tmd+?=
 =?us-ascii?Q?LtUJbXkOkJlCDE7bIaa5vkGVlDorn40+1evtAYmxdjlq0HskabxQ9EnQ3xB2?=
 =?us-ascii?Q?9DHtq8K0slfGWEwIjywKAn3CDdDE99IbiUjLgFIwlA07UzDStOWI7b33XSwX?=
 =?us-ascii?Q?zVa1KY3/vi8HDgv40JHqHGMZdz73lYosFTA7HF7wKVFbNxsOFUi72UG38UfD?=
 =?us-ascii?Q?eXdt1W1CUlFgBujZU9Gk8/3qO/l51Ar1WISOAkpw2NFEfDi5AmEhE8ACL9AD?=
 =?us-ascii?Q?koxgJJU+gyT1RhMOf8pri5MdQLOaz4ftDhU3dIgkrJQSu7CDNIVm3PQVBfW6?=
 =?us-ascii?Q?ucE8ClL/RqrmcU/Nmfcm+mF2phyY8fmqUJ2SQHhPBZYlPkcOf+IfwZklSb4Y?=
 =?us-ascii?Q?fXPxoqFe8yspOO8ppjRkvv2EJrMhyILybRTxcjPgg+4OkOCyfx+ItojgidgC?=
 =?us-ascii?Q?NytJtRVwyKWt0Xkga/fs84JqHM15DN6AB03iCzL44WayStcxw5oSQRPKVY6f?=
 =?us-ascii?Q?LEDx/CEEAZVhGajeyVweRBaMWvOdVElZIpBAmhLkJpzkqHJkcnnXSsfvbgCv?=
 =?us-ascii?Q?fcjbCqwiXhMoZzoGOuvA69epFMh/fTJC5JzpL8mZOwbUy6afnyKac32Ry072?=
 =?us-ascii?Q?/XA0gRGiNrUHhoxVDqCBdqjQBUjcIui3hiBJnDiN5Bc/X4JUe9zCkBszQ/hM?=
 =?us-ascii?Q?HS9W9DF83VJKMgIq/rp1GjhrIwz8Mm+ofwuMYIuaE9v0RbJqvkpUsWQqfsUy?=
 =?us-ascii?Q?1ITJoK3srB7vLQNnyntYXkZ4MKJLy8CqdSvZ5fYJslm8QHLlHMe2FLVgaT+v?=
 =?us-ascii?Q?E0S6TVSKQtfKhGNykW7HiNPi2ARmuEUZDvIWVl3+VndffMdiZr4xkeZx+dTB?=
 =?us-ascii?Q?svgn+zdiGTHU+aDs92pmWHLUkKksFwsnfzO/sGgyslbJkVIXZd2B15c5UJD3?=
 =?us-ascii?Q?Jn/yUQfUFBvkI+2G3n7m6hHUD8YzhsCqmsrIMO5KEgjjiKj7yvFc0MPKFcU0?=
 =?us-ascii?Q?uLrfupkSuHfKjirVkgl61hP3RFGLXN4KMfbcDcAQgn3xVK0hYWIKHEKwiA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR21MB5735.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I+aeN9Lpx/07Hr+B3TgErBNOFGCZTV7DD64+UKMfiHA0tqw+UJBJWusMJOXb?=
 =?us-ascii?Q?T/HDM73t19eDwstFOOiVcfLUsALLork3i8ccHlmlcaz28wb7HTmdJMld4FTA?=
 =?us-ascii?Q?txMg5ssnZfnSkyd9/fv7sqkSBCCkhJgNOaI7/f+1X1zlcj2mmVZduxCdZCZG?=
 =?us-ascii?Q?InQlU9Kyr9QNWprB7dI8f/M+6F/0i0AOMTbQAMC0WGrqQlRYqb6bl+soBcO7?=
 =?us-ascii?Q?t/z9E6/L+SkIDslBjDEzTi2gbxl6/5fLggk33JHdE5m0ulGjHM+DNwKbJqo7?=
 =?us-ascii?Q?bqb5khn0g/jLiDNwHkQjPZOFsjFu8GvfNXlYeXqw2rTi4XiY0lUE5vpUoyyg?=
 =?us-ascii?Q?oMMrzaGOacQgN60b0Ps1e16kYy9t88e7VFqN5TD0Z+pCTJ88oACIa2F856Pw?=
 =?us-ascii?Q?1dqmIw37Qce6q31zWTVCtLgwNtCHPbAV7o5ExjM7Xf2s36z2pbRNc5p2u9/+?=
 =?us-ascii?Q?jlszPLcnDiPXgmKEQvDFKC4mRZbN+u+NyDTUDTz1QdqFmir89K4swEydBNFD?=
 =?us-ascii?Q?FV8h0H21svfFjrJftZDWTf6FcENb6vIxWSXiNCkb6yGpHLtvG5NJvfhPVOR2?=
 =?us-ascii?Q?H9U7x6Trm9QwxM+XV+EK+VNFkdV2BN9IQ2eEIHU4r4RjTuvLIZ7opEc30/du?=
 =?us-ascii?Q?RtuFR7XObi5Bjcad3pzfC3DznUTCXG4Fv3fq8iFOiUqwKzA4cHxvSc8LEHIA?=
 =?us-ascii?Q?YpmQYftV2yJlcx9rurLgpZrI6Xy2OCb3GunuKZWMbzZKG975ejyHWyaPDPzL?=
 =?us-ascii?Q?ExIRG5QLP2GENq/N0CtacqfrFpQwpT6MIkpOqUe11AXhYb436Bs65MNZi7Ub?=
 =?us-ascii?Q?O38rNZ2GM4qGe59p4lGMiZBixeMfMk2aEqZQmj+49ne9y345i/KEoyDg25i0?=
 =?us-ascii?Q?6DCts0RRtE+L0KGh64At7XLPqwI4rUiXRZswR/rdUaFFQbL52/qbNaPuR0lt?=
 =?us-ascii?Q?h5J57Ma+xq6/swNP5zlZVTQdjlD+AGzw7wW2Dj+UYmO+JXGqsS+bLT0ACtg1?=
 =?us-ascii?Q?Xe/eggEUIZkmWCSTe8xARqHcpN2W60QKXtnX67z/IsXECThMlxCsBXhB6FAR?=
 =?us-ascii?Q?Pk47Z7l2gUyNoKZ9LDNcrm5bNITyKXp9OlmL6BdxHAdAVE0l/KvM8PtmE7fl?=
 =?us-ascii?Q?PWGuGt9Yberk9GGEZicxXRQxHDyjWUMKt8et69DIGwkcodUk2shR3cuQygX8?=
 =?us-ascii?Q?2Ri+JcQEcgv5WgEwLe7kMwkNEmwqO50bJgDG8T47GJ7CTSv5YJqa58KeK98t?=
 =?us-ascii?Q?zBTOSPoasxJZfofors4OFIceYlOLvw/5h2OIeHPQVvSJKfW5eosjp7WOfWNu?=
 =?us-ascii?Q?Hzxt0VBYs5imKjUJov0rorDoFNqiczRYSE9u7pe4dMyMON0C36UQcLNwiLi0?=
 =?us-ascii?Q?prGi+G0zsMWemodys6uBjoXsSMtc4dnY78JOfrtAhdTKaKshw7Sf63iFT2U8?=
 =?us-ascii?Q?QavQi5GzPU7Z82rQHA0VclljfI28qbPH6JfnZtIYiSmmHZtUnfEahJFX/2q2?=
 =?us-ascii?Q?k2igj9ZDVkO8RZn+jl15sBQuT7BAe2X5kAB8oauZteu3jgcTIR6zPVngioyz?=
 =?us-ascii?Q?kxHdr9esh2po+Viwd9G80bBG9GIimASSAXZw/3Ip0oG6uIVr9GAIIOpqYYtY?=
 =?us-ascii?Q?+1mGMQjjI2t89DZg+bLFDyZgjCo2ol3YEfXD7KbO0GWrRc99+IQMJ8nGodW8?=
 =?us-ascii?Q?Eu7UgE28VFXOzi9ECJOEAsCuHRzeJ71LdcbXxja1OEbBG1FM?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS3PR21MB5735.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ef0f27-ea2a-473d-7530-08de4d705780
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 22:10:03.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KkUxDv3UBvmedy+pbM82saeAKx4qUJ2ip7ShxtJwHp20NSeQ4XKKGqwwMJfe6AxB8qqsmbcASiGsPFbWxy4NPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR21MB4751

> Subject: [PATCH V2,net-next, 2/2] net: mana: Add ethtool counters for RX
> CQEs in coalesced type
>=20
> From: Haiyang Zhang <haiyangz@microsoft.com>
>=20
> For RX CQEs with type CQE_RX_COALESCED_4, to measure the coalescing
> efficiency, add counters to count how many contains 2, 3, 4 packets
> respectively.
> Also, add a counter for the error case of first packet with length =3D=3D=
 0.
>=20
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Long Li <longli@microsoft.com>


> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 25
> +++++++++++++++++--
>  .../ethernet/microsoft/mana/mana_ethtool.c    | 17 ++++++++++---
>  include/net/mana/mana.h                       | 10 +++++---
>  3 files changed, 42 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c
> b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index a46a1adf83bc..78824567d80b 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2083,8 +2083,22 @@ static void mana_process_rx_cqe(struct
> mana_rxq *rxq, struct mana_cq *cq,
>=20
>  nextpkt:
>  	pktlen =3D oob->ppi[i].pkt_len;
> -	if (pktlen =3D=3D 0)
> +	if (pktlen =3D=3D 0) {
> +		/* Collect coalesced CQE count based on packets processed.
> +		 * Coalesced CQEs have at least 2 packets, so index is i - 2.
> +		 */
> +		if (i > 1) {
> +			u64_stats_update_begin(&rxq->stats.syncp);
> +			rxq->stats.coalesced_cqe[i - 2]++;
> +			u64_stats_update_end(&rxq->stats.syncp);
> +		} else if (i =3D=3D 0) {
> +			/* Error case stat */
> +			u64_stats_update_begin(&rxq->stats.syncp);
> +			rxq->stats.pkt_len0_err++;
> +			u64_stats_update_end(&rxq->stats.syncp);
> +		}
>  		return;
> +	}
>=20
>  	curr =3D rxq->buf_index;
>  	rxbuf_oob =3D &rxq->rx_oobs[curr];
> @@ -2102,8 +2116,15 @@ static void mana_process_rx_cqe(struct
> mana_rxq *rxq, struct mana_cq *cq,
>=20
>  	mana_post_pkt_rxq(rxq);
>=20
> -	if (coalesced && (++i < MANA_RXCOMP_OOB_NUM_PPI))
> +	if (!coalesced)
> +		return;
> +
> +	if (++i < MANA_RXCOMP_OOB_NUM_PPI)
>  		goto nextpkt;
> +
> +	u64_stats_update_begin(&rxq->stats.syncp);
> +	rxq->stats.coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 2]++;
> +	u64_stats_update_end(&rxq->stats.syncp);
>  }
>=20
>  static void mana_poll_rx_cq(struct mana_cq *cq) diff --git
> a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> index b2b9bfb50396..635796bfdaf1 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> @@ -20,8 +20,6 @@ static const struct mana_stats_desc mana_eth_stats[] =
=3D
> {
>  					tx_cqe_unknown_type)},
>  	{"tx_linear_pkt_cnt", offsetof(struct mana_ethtool_stats,
>  				       tx_linear_pkt_cnt)},
> -	{"rx_coalesced_err", offsetof(struct mana_ethtool_stats,
> -					rx_coalesced_err)},
>  	{"rx_cqe_unknown_type", offsetof(struct mana_ethtool_stats,
>  					rx_cqe_unknown_type)},
>  };
> @@ -151,7 +149,7 @@ static void mana_get_strings(struct net_device *ndev,
> u32 stringset, u8 *data)  {
>  	struct mana_port_context *apc =3D netdev_priv(ndev);
>  	unsigned int num_queues =3D apc->num_queues;
> -	int i;
> +	int i, j;
>=20
>  	if (stringset !=3D ETH_SS_STATS)
>  		return;
> @@ -170,6 +168,9 @@ static void mana_get_strings(struct net_device *ndev,
> u32 stringset, u8 *data)
>  		ethtool_sprintf(&data, "rx_%d_xdp_drop", i);
>  		ethtool_sprintf(&data, "rx_%d_xdp_tx", i);
>  		ethtool_sprintf(&data, "rx_%d_xdp_redirect", i);
> +		ethtool_sprintf(&data, "rx_%d_pkt_len0_err", i);
> +		for (j =3D 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
> +			ethtool_sprintf(&data, "rx_%d_coalesced_cqe_%d", i,
> j + 2);
>  	}
>=20
>  	for (i =3D 0; i < num_queues; i++) {
> @@ -203,6 +204,8 @@ static void mana_get_ethtool_stats(struct net_device
> *ndev,
>  	u64 xdp_xmit;
>  	u64 xdp_drop;
>  	u64 xdp_tx;
> +	u64 pkt_len0_err;
> +	u64 coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 1];
>  	u64 tso_packets;
>  	u64 tso_bytes;
>  	u64 tso_inner_packets;
> @@ -211,7 +214,7 @@ static void mana_get_ethtool_stats(struct net_device
> *ndev,
>  	u64 short_pkt_fmt;
>  	u64 csum_partial;
>  	u64 mana_map_err;
> -	int q, i =3D 0;
> +	int q, i =3D 0, j;
>=20
>  	if (!apc->port_is_up)
>  		return;
> @@ -241,6 +244,9 @@ static void mana_get_ethtool_stats(struct net_device
> *ndev,
>  			xdp_drop =3D rx_stats->xdp_drop;
>  			xdp_tx =3D rx_stats->xdp_tx;
>  			xdp_redirect =3D rx_stats->xdp_redirect;
> +			pkt_len0_err =3D rx_stats->pkt_len0_err;
> +			for (j =3D 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1;
> j++)
> +				coalesced_cqe[j] =3D rx_stats->coalesced_cqe[j];
>  		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
>=20
>  		data[i++] =3D packets;
> @@ -248,6 +254,9 @@ static void mana_get_ethtool_stats(struct net_device
> *ndev,
>  		data[i++] =3D xdp_drop;
>  		data[i++] =3D xdp_tx;
>  		data[i++] =3D xdp_redirect;
> +		data[i++] =3D pkt_len0_err;
> +		for (j =3D 0; j < MANA_RXCOMP_OOB_NUM_PPI - 1; j++)
> +			data[i++] =3D coalesced_cqe[j];
>  	}
>=20
>  	for (q =3D 0; q < num_queues; q++) {
> diff --git a/include/net/mana/mana.h b/include/net/mana/mana.h index
> 51d26ebeff6c..f8dd19860103 100644
> --- a/include/net/mana/mana.h
> +++ b/include/net/mana/mana.h
> @@ -61,8 +61,11 @@ enum TRI_STATE {
>=20
>  #define MAX_PORTS_IN_MANA_DEV 256
>=20
> +/* Maximum number of packets per coalesced CQE */ #define
> +MANA_RXCOMP_OOB_NUM_PPI 4
> +
>  /* Update this count whenever the respective structures are changed */ -
> #define MANA_STATS_RX_COUNT 5
> +#define MANA_STATS_RX_COUNT (6 + MANA_RXCOMP_OOB_NUM_PPI - 1)
>  #define MANA_STATS_TX_COUNT 11
>=20
>  #define MANA_RX_FRAG_ALIGNMENT 64
> @@ -73,6 +76,8 @@ struct mana_stats_rx {
>  	u64 xdp_drop;
>  	u64 xdp_tx;
>  	u64 xdp_redirect;
> +	u64 pkt_len0_err;
> +	u64 coalesced_cqe[MANA_RXCOMP_OOB_NUM_PPI - 1];
>  	struct u64_stats_sync syncp;
>  };
>=20
> @@ -227,8 +232,6 @@ struct mana_rxcomp_perpkt_info {
>  	u32 pkt_hash;
>  }; /* HW DATA */
>=20
> -#define MANA_RXCOMP_OOB_NUM_PPI 4
> -
>  /* Receive completion OOB */
>  struct mana_rxcomp_oob {
>  	struct mana_cqe_header cqe_hdr;
> @@ -378,7 +381,6 @@ struct mana_ethtool_stats {
>  	u64 tx_cqe_err;
>  	u64 tx_cqe_unknown_type;
>  	u64 tx_linear_pkt_cnt;
> -	u64 rx_coalesced_err;
>  	u64 rx_cqe_unknown_type;
>  };
>=20
> --
> 2.34.1


