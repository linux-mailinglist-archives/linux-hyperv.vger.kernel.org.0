Return-Path: <linux-hyperv+bounces-8137-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D05CF0591
	for <lists+linux-hyperv@lfdr.de>; Sat, 03 Jan 2026 21:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C8C30133B2
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 Jan 2026 20:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20BF29BDAE;
	Sat,  3 Jan 2026 20:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="UVqV4ctF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11020087.outbound.protection.outlook.com [52.101.46.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2170D28F50F;
	Sat,  3 Jan 2026 20:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767472458; cv=fail; b=MzaUtPoe/j/Ydxu7sYqWDyWEFaYB7QUWKl0AFu+QqmmKehnAPx4yUpjEyZz9DfyRpMD5n/fqSnD+LSDbg+W/I7M5vaum/aTH0WvxwMUhfOSx2KYeNqgKWJIrZMBtvb6x0Mn43eZBpMf1ijo6c0MWF8BGXR8GlagS5UiNH9r2RCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767472458; c=relaxed/simple;
	bh=YhspdBsaW0kr0lSRrqunJszoCPBcl88DenyU8XcffRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=glkYpKKTPGlCC7ouKo7zKQzpsmWcFoiPT+7YqjcPNi4eKAjUZKRmZ8bSfeO1wxd1CP9VCgVd++Ueu1glzIvKWMczuO3gaT0xHkHewJr/xcQrozh4QDjhZhvFgOElAGeT3KR7B1d+/08Gep49HkHBsEEGmrO1de6ky9kYNM+W30o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=UVqV4ctF; arc=fail smtp.client-ip=52.101.46.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5YKpJqNNo0uJmEX9DyjqKxbefV9UhTovsuBME7VV7BiUBXllwRe5rKlU231kP3+V03w7VyFt0szhqF0P2T3xncZbQbZhLeHLyI2x8fxZ0UmVgirjEo9k+joKM4OAxSdHvJ1OSSp2asKCMcI45UJPpYUNk4M5edGAvwtTI6II8RrY0nZnjK1X2Udht8GwXV4sz1G7FSufNcjH5fkh5ky35i4fwBjUTfnO4kUt1TY2Hm5XJl29U9UEDrgD8moO22lar9Y1Bmc9PBz5LDpBbuN54oMpaDISdl0tQbpbdbh+7AlYt17GAMIkF7bHDnCng/3uZuFFYkbMybj423NpOqagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xy7QmyossDddd86txsmz6trUfWAkooOihca3M6/cts=;
 b=faAT1lzwjGOjTnBJQ1ixuxEX5mhfoFf6kWss0yBcJrLCw0/H1G8MtUskjAWBxql7Nvw3V4lQvUgszlymWS48Iov65Ybu1ox7iPVaFCo5/EwNqSvB8qH8A31msSKQT7vmfo1Z0WWs+oHYC9N1xAn5nYhmHKE32sDOzUl39PuRCt3v18e+aE2WT1DeIZeAul4iANEnMoX7x6Dxc+tuRe4M8fOLFKmQ+Byp6AdMWd+AjY7hSII8+HKZgboB6DoE0rDyyqa+YP+cFd2MVQthUyW5+mrYII1NoSMukPsV7noSFwPPTReMT7m2n73eRLFetHWs9Q2QG+t6LrsAkBZUmdYLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xy7QmyossDddd86txsmz6trUfWAkooOihca3M6/cts=;
 b=UVqV4ctFUHftkn+RP8Z9/upZMiL7WraxrIFNq3DU8wL0/FWtx8nX4p0XpFE9EQIUrxu8GELZ/qNpqqb88hMsgnCesd+Ex2q4c4jySYvkO+tUff6uoaQ4VKTjhLTOAOZAsO+thZVlPYs0vZ5KqN2SGR+GHTxak5v8XHc6uy1Rfxs=
Received: from SA3PR21MB3867.namprd21.prod.outlook.com (2603:10b6:806:2fc::15)
 by SA3PR21MB5771.namprd21.prod.outlook.com (2603:10b6:806:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.1; Sat, 3 Jan
 2026 20:34:13 +0000
Received: from SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3]) by SA3PR21MB3867.namprd21.prod.outlook.com
 ([fe80::70ff:4d3:2cb6:92a3%6]) with mapi id 15.20.9520.000; Sat, 3 Jan 2026
 20:34:13 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
	<haiyangz@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<DECUI@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, Long Li <longli@microsoft.com>, Konstantin Taranov
	<kotaranov@microsoft.com>, Simon Horman <horms@kernel.org>, Erni Sri Satya
 Vennela <ernis@linux.microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>, Shiraz Saleem
	<shirazsaleem@microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH net-next, 1/2] net: mana: Add support for
 coalesced RX packets on CQE
Thread-Topic: [EXTERNAL] Re: [PATCH net-next, 1/2] net: mana: Add support for
 coalesced RX packets on CQE
Thread-Index: AQHcfDAC9zbupp0oYUqTZlvwbw1m4rU/krmAgAFVTPA=
Date: Sat, 3 Jan 2026 20:34:13 +0000
Message-ID:
 <SA3PR21MB3867EFB48C19C1457B547F33CAB8A@SA3PR21MB3867.namprd21.prod.outlook.com>
References: <1767389759-3460-1-git-send-email-haiyangz@linux.microsoft.com>
	<1767389759-3460-2-git-send-email-haiyangz@linux.microsoft.com>
 <20260102161147.1938b51d@kernel.org>
In-Reply-To: <20260102161147.1938b51d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=430089c3-d348-4c05-b716-2a8f1cdb585a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-01-03T20:33:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR21MB3867:EE_|SA3PR21MB5771:EE_
x-ms-office365-filtering-correlation-id: ae6c9751-4922-4b65-63b0-08de4b077541
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?axy3BjRxHtioZrHgqXfyLoyrcfILG2J1QF8gaSKHw/489kP2tw2p+Vjn+N8c?=
 =?us-ascii?Q?WGHhALczoElA1BQYA7A+sR/cIv0IcLGXLJqOM02HgKRPhBtcRp4U1ouP4b3Z?=
 =?us-ascii?Q?Glc9iPA/DdO4p2CJpEOpiAPwmuTrvP777LmkOiUMxIYq2h6j6/cnAjXX5ofZ?=
 =?us-ascii?Q?Xp2XUAzhaR4Lr6C1YxLKk7mpJVIVSACm4Cv1oYFDhfKGYYtZXHopzY/rOq7X?=
 =?us-ascii?Q?mBJCSAk6kaJTGpKKQZvvqShSBxjWiQ4YJGXuJa2K+VG1t+7Z+BqsShMIEslg?=
 =?us-ascii?Q?JCD9uwxfcHiovUzHz9P5YKmsAcLESnZ8t6oCUeaoxNA1z4BhkcjkHlOGpYHe?=
 =?us-ascii?Q?JA52NdZWH0pWSKx+TmZG7Yt7BXzxoWwjqhRopOgNdggYZBgb+Cc7itplGC4B?=
 =?us-ascii?Q?LcfaAYKZ9LRoZJFjGDeiavFxWfvMVsu4NhamUA5lmlKnhAMu88E+nQo3PAsm?=
 =?us-ascii?Q?UV+9KXP9eqG8XfxNs/DsxwqXUyzm4xDxTb80zLa30Gr/N/n54iLBoi+5sQ9d?=
 =?us-ascii?Q?Hu67s/cJbBfwpbItoyCxRsPF7DVpfwfPHQnRVzSK+pDKDtWnGZl8DtkMAb1K?=
 =?us-ascii?Q?KJk6E8ZCOo/m8K4Y8YKjpi8CfCwmgXnpyjDefqeArNr6ExWJUXH5bK5CgZoA?=
 =?us-ascii?Q?bBGEZcJdUtpZdgA+3HQqBWLf1plUg1xtkCmncELY91YVH57/4yTEIy/mT/BS?=
 =?us-ascii?Q?ZoTrYNFbvcestRGCGObY68iree4yp1PYlqaLYIBUhldrJNtey15pbX3yd776?=
 =?us-ascii?Q?Oju5yBPCixuAwmV9qhr7qtnDlkRyLgrYNBwdDOxUmIRtDdK0/lJO5NdorPyl?=
 =?us-ascii?Q?pvFjBVj9W3mGiYCMmZZY7LzDXXZWxrcQxWB9NfEwSUfNlcIITp+KQDOKXy4b?=
 =?us-ascii?Q?GKSvu8LDV5HjfEDbYWBtthVq+QIsbPNQcOgP2O+VkhMo/H2EJkejwlZnHYiO?=
 =?us-ascii?Q?T24hBe0Tyb77uzt3YdMyXZMi5OR5prdscmr+KwPBByuLRmaaRuURs0ybONCp?=
 =?us-ascii?Q?vcxZxvss4res0TwLi7KygqV3prxNxRhBZmG70aQKLQZAynyM/qO33JR4AD6K?=
 =?us-ascii?Q?C3iSJ+WU7UhZvlysOKxYbYgeIAjANDXar7XhLds+RXjvptqSfXohnLd82Zk7?=
 =?us-ascii?Q?G7oS3l8QM/9UKYDdWGqitsVOnLM3B1vx1P8vKkrbfomgZkg2Oq4nUWFiSYv5?=
 =?us-ascii?Q?lQPpP4oirrPQiTu7tKT3HZl3/wGXEnQiLP3KljvFreFYX3NY/463p/1eqUzP?=
 =?us-ascii?Q?8GjTNvi7N720c2PUxJ+RzDTJgpcZJFw4/g0xg8xAouqDv1BzSLJIKkYWWQAs?=
 =?us-ascii?Q?Zsw/6wQ5cQqJol9ZAi+4vwkkgS2RJd40MN11UZo2D64paeGWdp5JLdGflcpk?=
 =?us-ascii?Q?xTiG/mohfT+3RRJamDMHP7WSeWBHyey2P8i+v5VZ1CvEAT4VvZlhv+4vuRV9?=
 =?us-ascii?Q?HxaiI+ewt3w2qO+j9PoTimmk7tv/fIftWxKsc0uacdAtADBfb1t6G4mv2rwU?=
 =?us-ascii?Q?WiBYTWbKuD7LeZngTCIUdJcACZny3mCL0BUq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR21MB3867.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LnpniloHq+Y9JI1pDm6SB0bwPnyZtFaWvJSGAfIWaq3I/zoS5Js0D40kEvce?=
 =?us-ascii?Q?uQuy+4jdguuwB22Dh1cVDsH8Ro87AypoRa/k0GHtd79+iUYsyjeNsgRLV46R?=
 =?us-ascii?Q?8eai3SZ6UcU/LH18G9cXjKknmpfXh+2Ry+/aEFtCVx4grkIRiXMcmqW0EdGi?=
 =?us-ascii?Q?pe4E8cve3uJI9UyVc3ng9DRLT3outPi3iXbl5K9ccAB7O5qPsbDNRZrwia/5?=
 =?us-ascii?Q?WK7qxTVg+bS7o+nhVGLtgFOSEDQ8izmO09AnKou1JzMM4wxFazFW+qQPyRcw?=
 =?us-ascii?Q?gF5eusjmtJaDe7qxE+GCIxNk6a7J1LL+7VB9e+1YeZBcTeHuvt5Y3o3h8mAR?=
 =?us-ascii?Q?rKaQ4i6egld5zxIslmP7Plzv5AhsrR7OFs5sCgdnuCvxcQpxvE4DXleYVqJQ?=
 =?us-ascii?Q?k0agBwYD5v0KBjsIL1BGEydsIW9Oezsww2g6Mb7d1pVAfGR7zKKstYq02rVV?=
 =?us-ascii?Q?F0+u7YW39xw1pS7rlenjRllqbV+ELCtObNGAXRap7mez1w8ZCIc4dNenpPzN?=
 =?us-ascii?Q?L1vNLtUba8uDTAlsZagWw+Ky4gh/G7OyD9CQXJ1lkLDRIvc70FGqih1LD1Rw?=
 =?us-ascii?Q?U7IOYRYuI1BXqSLo5Y2J+SOeN1UlnUQjrVGhWy76YIaMxtW0Nhl5gJR1KUe9?=
 =?us-ascii?Q?Dh53eUT5zmLjBkpN+cL2uQCr9UvVCp8Ge7V3+llGDQupfS3gUmFwfiUZazcU?=
 =?us-ascii?Q?eFGet/5R+v7Mt+CqYjzxy79VGjPRLnF5s1cecCgMbhzh5hJegGdL+8OGR8Qb?=
 =?us-ascii?Q?MBagq76sTlD6lPDIjk3QS4Gm89zgDrKTiKOiHFg+TBYeXCiJy4Twk5p28SkI?=
 =?us-ascii?Q?aKXYLLTWfDU+Evv9+bwFtcQZl7zinTH5UJDUe0WbsQQLZeTosjANb1/rdvmc?=
 =?us-ascii?Q?HVIY81RKGqc0C6BizwhC8l+qgy6m6J6Hsc8yj9C/tMZkhMXzvdFueOUmZvJa?=
 =?us-ascii?Q?54TVAjkOICIfONE4a932Phv6uYBhjUXTDghp+0odDs6VqhqLFZrharnRuqs7?=
 =?us-ascii?Q?uwfpvXhV3I1MPIWT4q5yxbHUHXwxQwNnJMlfR42ILop3biCJ0NnmCCkv27KF?=
 =?us-ascii?Q?2Ha8ngm+7/tBQhJTYrx2sFP8xvfqGskURwUhhpiHAuHqguZtej2S7A1+dZg1?=
 =?us-ascii?Q?DBskwVjZDQMt4VqnNEZCva8LX912TCxuCb/Hx8/T62dMGXJ4WhcdFVqqg7YM?=
 =?us-ascii?Q?TdKuJGO6Z3X7G2tQA74tzgxGUGPVoXXVp2eSy/LhBFuFxzASTq4NpQnh9ron?=
 =?us-ascii?Q?lG61HJ5qkHWHp6U5ul2jAIhexWY/GJ5z4uRb7Xq0x/kLuXGNsgZm6Mx4kA3l?=
 =?us-ascii?Q?CoRA/ZDmYizmzuG2c3ebz/Ek8rDYnNr2jABJGciZnPbTGmkwSBVsUG3uHD7u?=
 =?us-ascii?Q?JWr5fPyWDSODWLCEVn7IcYp9if0t1xPcUIPIxvvzwI+9o41NmXaTd9XLj0e2?=
 =?us-ascii?Q?JxZ6HAabtdyjsW79VvtUEKrX0pSSNHK2KIrw7J7UOPPJElBxRWL8UwMViS8J?=
 =?us-ascii?Q?e4f9hpweiR/L+NtJYxORh/d9aRuaRKjog3cxNsMqxC2fK0EDTH6bBEVN/QHw?=
 =?us-ascii?Q?hryMqJb/C46TQQsaeodrqfUIo7Onv074szamroMObG9NPqYaujIoR2v8IbGi?=
 =?us-ascii?Q?23lnKMgCCRo+j+RrCBzN68Q8E6zc8qNT5QbydTDPJDNEUtsrHEOktepzaTar?=
 =?us-ascii?Q?AZMyawlcMF9VX7LGLjTh4JHcWqiMHq26Ld8PntS0OwEmYUx6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6c9751-4922-4b65-63b0-08de4b077541
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2026 20:34:13.7097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFolhAs70/893Uelxs2KTLLr2QyEVDnL/P9H9nY46gF4jqJZbR0HkKC0iNejVQ8uczcConUlMzdNjzfmiGgUTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB5771



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, January 2, 2026 7:12 PM
> To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Paolo Abeni <pabeni@redhat.com>; Long Li
> <longli@microsoft.com>; Konstantin Taranov <kotaranov@microsoft.com>;
> Simon Horman <horms@kernel.org>; Erni Sri Satya Vennela
> <ernis@linux.microsoft.com>; Shradha Gupta
> <shradhagupta@linux.microsoft.com>; Saurabh Sengar
> <ssengar@linux.microsoft.com>; Aditya Garg
> <gargaditya@linux.microsoft.com>; Dipayaan Roy
> <dipayanroy@linux.microsoft.com>; Shiraz Saleem
> <shirazsaleem@microsoft.com>; linux-kernel@vger.kernel.org; linux-
> rdma@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> Subject: [EXTERNAL] Re: [PATCH net-next, 1/2] net: mana: Add support for
> coalesced RX packets on CQE
>=20
> On Fri,  2 Jan 2026 13:35:57 -0800 Haiyang Zhang wrote:
> > +		NL_SET_ERR_MSG_FMT(extack, "Set rx-frames to %u failed:%d\n",
> > +				   ec->rx_max_coalesced_frames, err);
>=20
> No trailing new line in extack messages, please.
> Also please do not duplicate the err value in the message itself,
> it's already passed to user space. Well behaved user space will format
> this as eg:
>=20
>   Set rx-frames to 123 failed:-11: Invalid argument

I will update the patch.

Thanks,
- Haiyang

