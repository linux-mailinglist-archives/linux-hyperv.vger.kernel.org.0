Return-Path: <linux-hyperv+bounces-9497-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDAqM2CKuWkjJwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-9497-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:07:44 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 745242AEFE0
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 18:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4064A30101FA
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2026 17:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C373F54D1;
	Tue, 17 Mar 2026 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="VdBkTqDD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022131.outbound.protection.outlook.com [52.101.43.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5F0357A4A;
	Tue, 17 Mar 2026 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767217; cv=fail; b=awmY8CcKbtwHiYrwQYtN2HZElJWjw1YAn/KHvIRehgP34I4qBEaOt9YkcejMG+LwjJPenIdI2tfPHI02BJb32E0V5oALSUqPFdR4EMevrhVxaaDO5wNGkfL76DmRWPwi11UDInVz13nKezDanp9ZnEOKr5zNDzf6nH5YuG97xHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767217; c=relaxed/simple;
	bh=Va//YrANgkhFMy0fHKWUKug+GR8w0mO+0oyft2zoehU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VhRHNjnOOp5FvHrVrnBAQrJg+bp8twrWTyAvCSsTP5ZiqHVqOYyyZaTyUmGAftiDaPp0RaydPJjw+YC69ob9aK7Gtxs7iwsooecgJnMFlugEGNZpcUElP1C3SeWo7z3tNvAJXnaDy9Q2rIkMevGe1OI/W39ECSb1ED3T2brwmlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=VdBkTqDD; arc=fail smtp.client-ip=52.101.43.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XGxN+6khuvS7d3zlDIdo68ybMfn8jmcz+G+l5aE5SpN/a2uF1KUXByDivcl3UwxfwAY796DcepZzU822hmTzZNUBNCsmWOKobLTlYUA1IardYakO8n9Sw7/r0cdRsbmW9vToMBjzWNQU/Snm9jq5F6CatdJkROINSS1brV7O52wleOAEMObBJaFQYENBNNLm+rtVDD+oisNnu6VNboD8/C5icZwA/TfmQfd6egyJi8JCT9lgQBzV7I48FsScLmOJy4Y2icAIF62yij84Upb9MRO4LIg6Vnhv7IsGfuH7tKIRMH8+4lVV8T7xTVp+mEiZd0q3T9ZH+RzSBIA4y9wxRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Va//YrANgkhFMy0fHKWUKug+GR8w0mO+0oyft2zoehU=;
 b=iL5NW9zkBXDHsJqDcRdx/zSKlxTCY6ryvui1zyZiu9OfQHXeZejZaC+l3KOq5lavetbqPvbfltZlIWL8dWoEUR52vdA4SI2IUiQMVWUvgJjx9Dni3ipcDoeeMJQ/vsBsdx8JWDrY20M47uV2gcPmePwT0qr15ivwSTLZApXuSc+fVmA5hVsujfItIfDeYohUP/sIpQheX7e1tOSlovxsXj8372jJyYPHl0RPGUW4Ui7y6We/8+xEsdkcdohHPILEbX4cx5f2XaxMAaLVqG6ptAMImiItZ6haVq7YuTY9bWXJuNPvPjsZc9bzcedbgSlrZOjoQnEpQfE+K5naKYfDZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Va//YrANgkhFMy0fHKWUKug+GR8w0mO+0oyft2zoehU=;
 b=VdBkTqDDsyqNez2heSPPFSl8IvoESA3jy438EfQ3XqbjvkQxZ53C+jvjMCjxyFnkLGjcPKRiV1uVQyackAcV+L8s/aTrbiD+QDdO/Lm6m0DFhikUyWsUrzKj9r+KcaTa1bK7nk1rZpD0tMYsCe0iOOf59bnF6TXRZdWhxUjgsB0=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA3PR21MB5699.namprd21.prod.outlook.com (2603:10b6:806:493::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.8; Tue, 17 Mar
 2026 17:06:53 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9723.006; Tue, 17 Mar 2026
 17:06:53 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, "Kory Maincent
 (Dent Project)" <kory.maincent@bootlin.com>, Gal Pressman <gal@nvidia.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next v5 1/3] net: ethtool: add ethtool
 COALESCE_RX_CQE_FRAMES/NSECS
Thread-Topic: [EXTERNAL] Re: [PATCH net-next v5 1/3] net: ethtool: add ethtool
 COALESCE_RX_CQE_FRAMES/NSECS
Thread-Index: AQHcsle3ede9x30umkKGpMq4Ws2CzbWyEOAAgADrHmA=
Date: Tue, 17 Mar 2026 17:06:53 +0000
Message-ID:
 <SA3PR21MB386739456243DAAE93491110CA41A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <20260312193725.994833-1-haiyangz@linux.microsoft.com>
	<20260312193725.994833-2-haiyangz@linux.microsoft.com>
 <20260316200434.3a0b99ec@kernel.org>
In-Reply-To: <20260316200434.3a0b99ec@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bfc6c982-1d46-479c-ac5f-9678c6241991;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-17T17:06:04Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA3PR21MB5699:EE_
x-ms-office365-filtering-correlation-id: c8e0e654-29b2-462c-829d-08de8447963a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 xgoX7zBA9bFaV7P+7W2/Q/YKsiH93afpUGWg+9AHA2sY3z6c23bEc608MV4SXA1yOeWRROzv5xdvo7yGA9sP0NfLrQlJqPO85Ofs51QKFaMOVFGv3VvqHjPZpB3dtH/dw0uTjOtkVyvOB+39jik8Vz8FwAlZXaqSYRdWYX/VLdLe2jM8YR793KE4QcwHCNUFJ4mTJ1Ycu1pTeZ4N9ze8RPrOh31O9NMcU2TWAT9l1kpQZde5+4+XFib7iNLpaM/EknGO7GO/2d/7hRA449UnKrEV+JWBSUEDgezywOrpap77J03APT+pvFgzJl8illga8ePoZCHXZPp146zqs7c1DyqYmPJz/NClWV+xwKCF+dVYP88ItvFvZVVx3pJRICtBP/bMehecoIJYorwKPcz8EHwFIEvcoq62nZOw4Cz7i1m3nAnRlt82iiin6FV+V/y8FFSJ+7NMioo67JiTsrZO7FkPa3409JUbhkNaFRasW26kTZAnjnve1fpuIUrR8Li6joCVxxEjxFi3IUEy69OY5rRT3S+FzL2U9xQVChTEHgUIcfLCbZxKFyT3vDlzdkXgwygX7cws6hqSz1s9iLe8HjZOLmZf+Aakwnsmoos0UeEPwWvgqgECfqmXx+K9KKYJrlmge/INTHq+rp6dv/zBt87ah5Eduow13RTc1ggUFR6Z+6m57lgER6BrH2vAqYVo0O0SSi5Bp8M8i4Rb0X1Tnx3C0eEYGo2NwGAUVPlJRT27eHrhJHq+85MkmPYhP0IHZHP6Z3gLyDZrLAdob63/dkdLj8cc+5nPpP1FpF4W+P8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9TdlStsPH8N3vT7QdhdAQWYyHu59lI9qZymSvFWcyipYn33q/Uxw7BBYqv/v?=
 =?us-ascii?Q?9pAY7FcQUSUhM/yJeId72XFx/hy5Gd4Od8TvQVsZfbv/u8dJ6++1i3bPX6O0?=
 =?us-ascii?Q?xdoYzytvs0u2lx1ifQVzmjB/De2NA+LpW/gPQwzJtMbyQAfJ1K/BrrbSurK1?=
 =?us-ascii?Q?aEMhrKYA/ARyKIs5Mpxd1NvgKBfWWAjYMm4b1XX4FZofNgGTmI5QmYVlC7i9?=
 =?us-ascii?Q?AAEbZQ/f0Eep/JqoNoGVnPP2sqMkv8G/lVvF2Sf8thGOADWTtGdioTv2SpNH?=
 =?us-ascii?Q?RQB7+sacuXuUlhqFxzCPJuH7Xth8b5UD2SEIiN8e6JdDugy/nzXGGTJagB56?=
 =?us-ascii?Q?FPLD9+DEYT1PT2IcqLBKUmUo0jr3exzVawIgGqFAf97LyrQlYzr9UQ9HFSbC?=
 =?us-ascii?Q?P36nbkZYd7WsO36d6W9+666LiMTERXOOfTjS7s2q3c+yughYHNasFxOJYbRv?=
 =?us-ascii?Q?N1JbcjXZGfgsC853dImWT3ecEAK1UggVWwN0mdv+KDa80hVx6bdaFI3IKzuf?=
 =?us-ascii?Q?SrJUIFN11w7JpgxQfaYX7+r1Xi3L1N4x9MzEn6BZVgYFEJyssBsJJmDCX9SW?=
 =?us-ascii?Q?mb/5tZSsCccROyUxfvLI1f+O8c5T20OpreJdCS+h4baMrhJ2Z5zkYBEPWcsD?=
 =?us-ascii?Q?cnsDr/V8Ud9yjBz0DX7IYPINf8R8Lmy6w6yu/qVOF0SkZksVt2xfIWu6qBB/?=
 =?us-ascii?Q?zBaeISVtwEkAPfyIKEbWX+KcUGTRXn8mBL1hw32piOR17Gm65EItsuDu/POQ?=
 =?us-ascii?Q?pkXvlNwgjaOYesxHWCrQKhIgMsGNJTcj3ao/kCX57LEwsTMjiO/EvPJLEoRg?=
 =?us-ascii?Q?cVB4PEANAc8sEqjvjlGAnDu/WSaBjg5ucl3dsqYcnI2pj6RQvgQejqAXeQ5y?=
 =?us-ascii?Q?eExpacU51xL3uOTQXJTagmnRwCWj8vcRwZpR5LTeW+qbX7nIQZnawoRoX3WU?=
 =?us-ascii?Q?MObjqrs0H8kgue2QvUVfJIR8fluVhvnmHy3cx1BafywroNanNyBm/nXQlPvq?=
 =?us-ascii?Q?cHoA5xvL5/J6AOZv71yNjv4O3OG7SUbpBjNjcF3f3zBljt85NmRZnfit+Mra?=
 =?us-ascii?Q?aWLqeIeyYpqiWCENey/oil2DMkWEys5qmCFpqbB4NRceSmf7dDRdfO7rx3zw?=
 =?us-ascii?Q?4HA95H1G7NqjUqz3OOuRnq/SzkfkUOHo5ywUj7E2AOc9XxMHG/s0Hujq9vVS?=
 =?us-ascii?Q?8+IYnll/wneA6LVpahq5QyMEH7fkYaMn0IBT0pZuNAe6UU0VUJnfQYFR6NAU?=
 =?us-ascii?Q?gu1q6vIpZmbOztHubRqvZlZ2oKAW0z6wXX5kOMMH7ipB4zdbwwWrGcgAtE0V?=
 =?us-ascii?Q?WpnLyIcLbo3wNe9rbdrS6I3dHnYFxZ/AWxQXYFA3Kn1PxFzuLYKPowx+mGGW?=
 =?us-ascii?Q?Bj+Bm2EPDErL/i8cUWSlZrUSMofbo8NjPErG9Z0zEYFdruK+KZTvj064K7PZ?=
 =?us-ascii?Q?y8kYZLOzcJv02ThuQQj+PyIEjDlZImVl8gIb3SIljec2mtZpyICvAuT6F8eG?=
 =?us-ascii?Q?Tt7QpCFvaBR5AaomfZ7kJZ+YjH58cGwZVyrn3y1jJdv7Q8dP4dPP3S/5Dskb?=
 =?us-ascii?Q?FzhyiX90wWcoiUVEkXDHA5sbhkJdD+u4mfJFpzRTm6FfaP6EGbB1HX32YeGe?=
 =?us-ascii?Q?GZxiEGuli07TxrKGyT4CR61Cgeu8w6X1HmfgyddPRc95+1QaDpsDfYsw8GzV?=
 =?us-ascii?Q?zjg22V7UIcIWrWBG3b/Q/ZPwnnYZSTBlh6vrKrVhn0AGaDVPo+1nVpcRuUNw?=
 =?us-ascii?Q?qnTWScn5AQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e0e654-29b2-462c-829d-08de8447963a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2026 17:06:53.0975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUAY2eWiQusV1Y9itb5vFwAAC2f6Ob5b5iTFxKaBIYuPI2Zyj00ymFxqcwVv5Jk5KCLcN1pI32kiUcEGSu91Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5699
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9497-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,bootlin.com,nvidia.com,pengutronix.de,linux.dev,microsoft.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haiyangz@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[microsoft.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 745242AEFE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, March 16, 2026 11:05 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; Andrew Lunn
> <andrew@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Simon Horman
> <horms@kernel.org>; Donald Hunter <donald.hunter@gmail.com>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Kory
> Maincent (Dent Project) <kory.maincent@bootlin.com>; Gal Pressman
> <gal@nvidia.com>; Oleksij Rempel <o.rempel@pengutronix.de>; Vadim
> Fedorenko <vadim.fedorenko@linux.dev>; linux-kernel@vger.kernel.org;
> linux-doc@vger.kernel.org; Haiyang Zhang <haiyangz@microsoft.com>; Paul
> Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next v5 1/3] net: ethtool: add ethtool
> COALESCE_RX_CQE_FRAMES/NSECS
>=20
> On Thu, 12 Mar 2026 12:37:04 -0700 Haiyang Zhang wrote:
> > +Rx CQE coalescing allows multiple received packets to be coalesced int=
o
> a single
> > +Completion Queue Entry (CQE). ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES``
> describes the
> > +maximum number of frames that can be coalesced into a CQE.
> > +``ETHTOOL_A_COALESCE_RX_CQE_NSECS`` describes max time in nanoseconds
> after the
> > +first packet arrival in a coalesced CQE to be sent.
>=20
> Looks good overall, can we broaden the language a bit?
> Replace "a single Completion Queue Entry (CQE)" with "a single
> Completion Queue Entry (CQE) or descriptor write back"?
Sure.

> I'm assuming your devices don't coalesce CQE writes.
> For non-RDMA devices the notion of CQE is a bit foreign but
> descriptor write back coalescing serves similar purpose.
> In either case host can't see the frame even if it's busy
> polling.
>=20
> So:
>=20
> Rx CQE coalescing allows multiple received packets to be coalesced
> into a single Completion Queue Entry (CQE) or descriptor writeback.
> ``ETHTOOL_A_COALESCE_RX_CQE_FRAMES`` describes the maximum number of
> frames that can be coalesced into a CQE or writeback.
> ``ETHTOOL_A_COALESCE_RX_CQE_NSECS`` describes max time in nanoseconds
> after the first packet arrival in a coalesced CQE to be sent.
Will do.

Thanks,
- Haiyang

