Return-Path: <linux-hyperv+bounces-10383-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEMwDqX27mnS2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10383-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:39:49 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E546D453
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 07:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FD6E3002A11
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 05:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBEF31AAAA;
	Mon, 27 Apr 2026 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="IpCMVBCf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazolkn19012074.outbound.protection.outlook.com [52.103.11.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9895E40DFA5;
	Mon, 27 Apr 2026 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777268386; cv=fail; b=OyQ15lV0EFkrViyQnb5SOkjuRPgze4IOlVGGj2Fz9M/1EYnozkDYq3h1V9fGpVMKGF113dogT/78ZTJM5uBHAUaHBdWMHDs43mOdn81eYIlQcqii710cAPWsLECvIRR9cCSTkEl1ZTcl/pWGSU6wskXzUj82zxjrp/S2R2aQ5rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777268386; c=relaxed/simple;
	bh=UB4TTRS/s9ehiZ1V1zKHwHEL/6PDGuTv1E6XdJui4Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mE9jVrPMH63vF2KWcv4eFkaPNzIbjth2A34wNwk7XJwcVQkis2vrzncBLkEeHqeokWyGJP7kmGVXQwODah9hO/K9Qyyr2X2PupX+ozxQFk1e0dEAZCp/DYy/tqDm60iu140o4RMieLmW6viMSAKORS3VDIRBfvYfIvNiMmE60JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=IpCMVBCf; arc=fail smtp.client-ip=52.103.11.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wc1Xfj3xx8lP6PfbPG22SRqxNfc1d8ck0Q3ybDh3QexniF3Ptiqmv+sjGa7E4Tdry/KhyRPOSdSEGL5+XuI4STau1L0rcS3wDcsHHKB8FNqj+BxP/UWd3qf4dSKSPviYfLyERBZMm9WI4WJphq2FE33VNL41s/4WmeXhCw9AesC/V6masKGROv6WyzeYD1iiyYRZGcQABcUt6Zhp9QZUpCmnJVbrKmCSEwKRSWLSp3u2UkA636GQfHkXQrQJtaCo+8znsPb/CBHgd3VpzeimVOIj4avB0PsO22stxeQ0FfHJjIUFaAm3BO5iqcjESjb++zLjZclRAH9jNrq9+9a7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39I98Eka6Y7j1KT33387jvDeua8mqkAfFVgVIee1a5s=;
 b=CvqFYmVTGknKWBS0LjZGQbgRKnAs7dNafudX8TzfKT4Uh32/omZwq1B0JfOVb4VOwXl7AZaVV1GSHaln/q8ckYX1T9yn7y5D7NiM/r6xGwqE1T+bjX7U/+HJ7AE5ERW4qmdpVWDKXwtuT+YlFlU6g1uGcCluZI4POX9Lf6Q1WRsmlj9Q7PYPP1LBPx1dmSlOZjzTQabEKoIUOqcuxLkLApEImXtZqh10RHO9TNKMWp7O++x/3tYQaCR+vHuFYZRlSj4frAbZRkYvW6GT2yeMbN+YO4CgVHRgKBYt8HShH6RprL1QvQQfemTwSBQq8jbky1Bm+K3T46arGEmq7maq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39I98Eka6Y7j1KT33387jvDeua8mqkAfFVgVIee1a5s=;
 b=IpCMVBCfMCDo2c+arPqEbpv64vWTU1hwM+YOOw6gEeu61mH5T2CDdXGCHae8zzIjscI42n/adXLIJDgBvlq4V2zVyJNipKjMNRHvGHJeHxONpaTYPAxUMUKTfMS8PnQvPWreqxYu2CpIShroXjZKoeYUqUyFnb4hcQTay/YcbXR9u85LfEdpsZ1CWKGW20D3yQ8c9ZDQ86nvetmSec/su9TN8KBP/jO6/Fcx5cCkGZput/aHoCL+Vkz2SaXakmvPwEY8d90O9cS9hDgYt7AaBzPIHvZ4UvX0lBfC9A93m6bcFj3jCOwjdQYR+xtuO3T+thSoDeQOsKLxK6zVb+kH+w==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CO6PR02MB7809.namprd02.prod.outlook.com (2603:10b6:303:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 05:39:41 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 05:39:40 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Naman Jain <namjain@linux.microsoft.com>, "K . Y . Srinivasan"
	<kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
	<longli@microsoft.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar
	<mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Michael Kelley
	<mhklinux@outlook.com>
CC: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Sascha Bischoff
	<sascha.bischoff@arm.com>, mrigendrachaubey <mrigendra.chaubey@gmail.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "vdso@mailbox.org" <vdso@mailbox.org>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>
Subject: RE: [PATCH v2 08/15] Drivers: hv: Move
 hv_call_(get|set)_vp_registers() declarations
Thread-Topic: [PATCH v2 08/15] Drivers: hv: Move
 hv_call_(get|set)_vp_registers() declarations
Thread-Index: AQHc0x7KhQKOv+E980uDaIJzKtjb97Xyaj0w
Date: Mon, 27 Apr 2026 05:39:40 +0000
Message-ID:
 <SN6PR02MB4157852404B5258EF13A5450D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260423124206.2410879-1-namjain@linux.microsoft.com>
 <20260423124206.2410879-9-namjain@linux.microsoft.com>
In-Reply-To: <20260423124206.2410879-9-namjain@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CO6PR02MB7809:EE_
x-ms-office365-filtering-correlation-id: 458a4304-d75e-451f-9fb6-08dea41f60d2
x-microsoft-antispam:
 BCL:0;ARA:14566002|12121999013|51005399006|55001999006|16051099003|37011999003|13091999003|19101099003|461199028|41001999006|31061999003|19110799012|15080799012|8062599012|8060799015|40105399003|440099028|3412199025|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tKo4W64Hf/Zx95Gmy3QZquUsjZgDgxcHvq4c0azxeTRfIQih6qViye5vgtlo?=
 =?us-ascii?Q?LlIifuvkOjtWWcPII5kjefroYddXfzue+cwVVsUk9kWTgpfwxcXTGh0NY8lQ?=
 =?us-ascii?Q?xY0EuLq2V8+65jdEKcnXPZJybQuNGjT8cW2g8/OaxJRATZPqGfFVH0ON1nIv?=
 =?us-ascii?Q?WBg+bdxU5MBitDfAIYM3U2B7j5cYay1qH5HLmzBhq/UilEjddfqHC8f224E5?=
 =?us-ascii?Q?gWzVCiFYgPLZsC2c17Qj+wXaOoff4PZM1jtsmEPrqgmBGtpOIVgodfu5OSzd?=
 =?us-ascii?Q?TDHHTt6zKWIabYivWrgEeNPFLDv/N13WaEn3OWTYmdwb8zv2b54hUgu4NARL?=
 =?us-ascii?Q?eXDInJpmoVO3w6azyfP8UcuscFda6fl1boaHdcjiQzXLipBkYTPPLYRslQ0r?=
 =?us-ascii?Q?7isEn9vXn2+V/4ovQ7cYZ/aSHqclqk0X+yQYd9AHMSYg4R0I56VLCb+o6YsA?=
 =?us-ascii?Q?jA3oamAm6tF0QuWYc1G9s5ZJ6sLZKeFBoHyyG9zmrlXA9jAgxWk8I4hl+jWc?=
 =?us-ascii?Q?aDercLPHCz4cskyvtHkKguArVJGOzQq/JoyaCXJ65j6F27t2eIUIJBDETMiE?=
 =?us-ascii?Q?WTxP+XNFk7T2XTP5fJUcrczwir63o+PNxPR3YbbpGhEKuhLI51516C/Hroz7?=
 =?us-ascii?Q?1T38lgAK4Gi4Iin8KTSy/GipGly5wGTwYCkCWFEc8wEkUgy7V3BRQFat9+ej?=
 =?us-ascii?Q?UMw4vHx8fRGn0oWVs2sD9Sh+X/YpCecS79QRU0S/QgWq3oMFBxmvUncGBQEY?=
 =?us-ascii?Q?kGuvQJSaJdDykY2SysVu+UeZ/a1JaZ7OUXV7SD7e1Rnb9tf9pBCH9/GUDTEx?=
 =?us-ascii?Q?wAOYQiTsPBnXMgo1rXa6oO1RGPkQgc6EsKgN4MlNeW/3Tveh093jMm7eXnoY?=
 =?us-ascii?Q?anv1q7DzNUsTzcxLQ4iIt8m1VBkxuWDpdLcBeN7qJ9E01PXQRUEtsJl/Xq1x?=
 =?us-ascii?Q?OoDoXRLSmmvO3opImHCQIUAHFyPELLMZgZswML/CF4ZQdOHLf0WNaR9HksW3?=
 =?us-ascii?Q?5nm8+EEMIbCovhk/FLJUY6dyyGvFrfiJAON0kK6x9/DeulvlA854Q80fqiCK?=
 =?us-ascii?Q?bjlPZa0aTM4nrWCXp1pzseCKrEHUPf0bD0HDPdA7Vbdtat8jA0FhuIyTbzVx?=
 =?us-ascii?Q?glaS741Tf9feuInKySs4LZKLIUakln5QKg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?M6MpOWu8/hyA3/Mi9vemHKpvMKzh8zgHHpx4+I9oA6aRWEW982/8dVw0HvAL?=
 =?us-ascii?Q?dG/MQX9ZZ0D1KwZmkm1c5072akRa96Xk0EdVRCds5nuxbyRShsUZCYCysVV6?=
 =?us-ascii?Q?UXWIJje8BPyboZTi3u6FCOtpaCv6VsQlKaaFabEcefIUNeVAdsghblx0l96k?=
 =?us-ascii?Q?yIkcKULWbTECk7Nvvof+5TcUVi11EVJ7f++2cnzkJeOYumqupgZFPyA2kOGB?=
 =?us-ascii?Q?fJklJDMPH/iRqONTx5RnpOAFXhNx8f3EDHIrcQcGwoNKJkI2xrz8hO60aZC/?=
 =?us-ascii?Q?ridn1uuiOuqCUXqK2s+T7f+G6VyZJCNrvOdHD/i5/0UEc3mYfzY+jl+NRlKt?=
 =?us-ascii?Q?IemCZy60y0c9nh+LgvXuuYA20b7RLf2wbJfIjBI0475KotJZYC0+5C51I47j?=
 =?us-ascii?Q?cvB3lEp2LGb1VoDPbv5JvODJSgSh//cYH6miT6MlUItlYFtAcetJxxqBB23V?=
 =?us-ascii?Q?USs4l5nO85dj+VIAgrM4Nvfw1EpJ1ZmZLad+zm8O1B3Vq2r1K4ScfyKX+QYc?=
 =?us-ascii?Q?0rD+HrtZMLQ0pv+ObmZKQ4xuH9JDGNQZyWdcmf9r+5NvP/jzSoDuKPYFPyk3?=
 =?us-ascii?Q?qMBcuY9VtBo/RghwHtNZt2XSPd74yOoBGE0VdLJAr3Q4ct/VGMuXdl2CniLF?=
 =?us-ascii?Q?kYUAm7alP3F8r2d/XpNybNt6tb127AAjcLq4bvV3dFSx0G+AXEY3i1sBL0mP?=
 =?us-ascii?Q?al8f+wikEo098pb7VlpJJEz08dM2bz0/HM44JkGpcinaBHy6k+9FfzwogtJg?=
 =?us-ascii?Q?T5Hxe+J67F4yMJAGFjw8NlQP9k0ifeOJKHiZW0uheSY0xfrCjkxrxROuW2De?=
 =?us-ascii?Q?ndAL8PHi/Pfvw7NmT3Ui9lkagHvMrlD+G5F/qACb+1qeFNGtRWyt+HA1ipt0?=
 =?us-ascii?Q?RWCFCIWxBqt2OXh9aMSR5VLr7gkvDCAi6bDIq12/l8XEupX1P4RnHlQKW3c5?=
 =?us-ascii?Q?tLvp1XaT81bYC/2CwyQ7GZNJufiIWbAGJjUzylGbFdvxOXq8xfQANihLNkiI?=
 =?us-ascii?Q?dRTO07IXAVUcU7XrlAq46i310/H4gzPCfEBQGrS7DCFAFAP+MIm8j87jaNPV?=
 =?us-ascii?Q?GkY47TAfREgq2lcFXIDycL0JToK849emRy4DbOOps5b3XD7r6WPTtszttK8r?=
 =?us-ascii?Q?UrcXJoxE/NPD5hCJqSHB9+tZrx/GCqPws9reW0ofSGNKA3UAvX3gJyUpQ2Mk?=
 =?us-ascii?Q?msR9+pqUNlVnqAEXs7emvP1poXPmW0fOecfnRoWjYJpwsba85VrwuCjoA42S?=
 =?us-ascii?Q?2WZDRUCLJvogi6OaTxT/KOodT0kQyQPoTSaSvkHovmQ6s+S2ygmZEcMK+0fn?=
 =?us-ascii?Q?aLOxIfg9SmgkI6zD3of/BKSRjRoCcT9IbDcswVcOqRK0UyCcC0Gf5mGEsCRJ?=
 =?us-ascii?Q?00SxF2c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 458a4304-d75e-451f-9fb6-08dea41f60d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 05:39:40.8138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7809
X-Rspamd-Queue-Id: 8B7E546D453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10383-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,arm.com,redhat.com,alien8.de,linux.intel.com,zytor.com,arndb.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,arm.com,gmail.com,vger.kernel.org,lists.infradead.org,mailbox.org,linux.microsoft.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[outlook.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, April 23, 20=
26 5:42 AM
>=20
> Move hv_call_get_vp_registers() and hv_call_set_vp_registers()
> declarations from drivers/hv/mshv.h to include/asm-generic/mshyperv.h.
>=20
> These functions are defined in mshv_common.c and are going to be called
> from both drivers/hv/ and arch/x86/hyperv/hv_vtl.c. The latter never
> included mshv.h, relying on implicit declaration visibility. Moving the
> declarations to the arch-generic Hyper-V header makes them properly
> visible to all architecture-specific callers.
>=20
> Provide static inline stubs returning -EOPNOTSUPP when neither
> CONFIG_MSHV_ROOT nor CONFIG_MSHV_VTL is enabled.

Looking at the drivers/hv/Kconfig, it's possible to build with
CONFIG_HYPERV_VTL_MODE=3Dy, but not CONFIG_MSHV_VTL. In such a
case, mshv_common.o doesn't get built, which is why the stubs are
needed. Is such a configuration desirable for some scenarios?

I wonder if having CONFIG_HYPERV_VTL_MODE force the building of
mshv_common.o would be a better approach. Then the stubs wouldn't
be needed. The "ifneq" statement in drivers/hv/Makefile could use
CONFIG_HYPERV_VTL_MODE instead of CONFIG_MSHV_VTL, and
everything would be good since CONFIG_MSHV_VTL depends on
CONFIG_HYPERV_VTL_MODE.

>=20
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/mshv.h              |  8 --------
>  include/asm-generic/mshyperv.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
> index d4813df92b9c..0fcb7f9ba6a9 100644
> --- a/drivers/hv/mshv.h
> +++ b/drivers/hv/mshv.h
> @@ -14,14 +14,6 @@
>  	memchr_inv(&((STRUCT).MEMBER), \
>  		   0, sizeof_field(typeof(STRUCT), MEMBER))
>=20
> -int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> -			     union hv_input_vtl input_vtl,
> -			     struct hv_register_assoc *registers);
> -
> -int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> -			     union hv_input_vtl input_vtl,
> -			     struct hv_register_assoc *registers);
> -
>  int hv_call_get_partition_property(u64 partition_id, u64 property_code,
>  				   u64 *property_value);
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 8cdf2a9fbdfb..ef0b9466808c 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -394,6 +394,32 @@ static inline int hv_deposit_memory(u64 partition_id=
, u64
> status)
>  	return hv_deposit_memory_node(NUMA_NO_NODE, partition_id, status);
>  }
>=20
> +#if IS_ENABLED(CONFIG_MSHV_ROOT) || IS_ENABLED(CONFIG_MSHV_VTL)
> +int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> +			     union hv_input_vtl input_vtl,
> +			     struct hv_register_assoc *registers);
> +
> +int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
> +			     union hv_input_vtl input_vtl,
> +			     struct hv_register_assoc *registers);
> +#else
> +static inline int hv_call_get_vp_registers(u32 vp_index, u64 partition_i=
d,
> +					   u16 count,
> +					   union hv_input_vtl input_vtl,
> +					   struct hv_register_assoc *registers)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int hv_call_set_vp_registers(u32 vp_index, u64 partition_i=
d,
> +					   u16 count,
> +					   union hv_input_vtl input_vtl,
> +					   struct hv_register_assoc *registers)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_MSHV_ROOT || CONFIG_MSHV_VTL */
> +
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  u8 __init get_vtl(void);
>  void mshv_vtl_return_call(struct mshv_vtl_cpu_context *vtl0);
> --
> 2.43.0
>=20


