Return-Path: <linux-hyperv+bounces-7414-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D06B1C38286
	for <lists+linux-hyperv@lfdr.de>; Wed, 05 Nov 2025 23:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5758D4E4E95
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Nov 2025 22:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9ED29D277;
	Wed,  5 Nov 2025 22:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eS3TFBJK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC9265630;
	Wed,  5 Nov 2025 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762380980; cv=fail; b=I3FQpH6XCp0tGkM9HPoGhnYTnYFQUew6G/zGwrgdHqdn+g115L0iOAwbU0ZuHFrJrgIBc9LG1ImPOQplSsnVhORWWm7sNxw5AtVtnvqOJoSMpov71rx3teORQdyqheQFObqqnTmmLg/BcbU66DvfUDcPVEQVrEHBUlL5U2JTNzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762380980; c=relaxed/simple;
	bh=kCieRLGaxHjVqqGUgxL2YNhMW4ZEahkExmkb2YBZq+c=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XJuDtkpzOmlok8RROfLZGLQ5PI3QhVNVEkqyPYbEfWcxI7oSMyvBD0EPHsDb5o2RnMiOFqodnd3TCIerbRGsVqtjPSzJOmorVnGyNyweNCguKI6V0ZcNJMQlpt/bEAHZ0VUS+yjtGr8g2nT/P4oF2lNU4BPCtuazNjvBcmVMAjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eS3TFBJK; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762380978; x=1793916978;
  h=message-id:date:subject:to:references:from:in-reply-to:
   mime-version;
  bh=kCieRLGaxHjVqqGUgxL2YNhMW4ZEahkExmkb2YBZq+c=;
  b=eS3TFBJK27LDgEKPCyXBCYwxmosY7iOiyUcqtRLwOSAhUB4twrNXy3AV
   fdtXpm4YGWjoI3VO1lcofbu4I4fv065baEU4x48AZiHUjhvLK2t63nOeD
   0MDdxPfSqaJ7htR73p1nsrme3qee459xEFcduDPOEQQC+c+jxtwTGM9E2
   1OjgldUeWiwznyRY2XNPj8GZber2j7Xk2KTQliCvNBzRGFgDPr4ZwW3h6
   JB+SM1nU+Utu8Pbo4uZkW+PegOKR37kU5OFIawgmbBvamv/u8pFkwbS+v
   KAocy4b6CY7M9sa1GWJhd7Y1gqJvSd/m7Yb6y5r3uxBBgPnRG1CBcvkfF
   A==;
X-CSE-ConnectionGUID: R+75NxuaRLSPFBFsH6oU+A==
X-CSE-MsgGUID: aL/iXFPfR4SP2CxYxFfICA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64205684"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="asc'?scan'208";a="64205684"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 14:16:08 -0800
X-CSE-ConnectionGUID: aoVlB2WHTY6sU3wppdATaQ==
X-CSE-MsgGUID: UfbhT9gpQRWF62/kJlHROg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; 
   d="asc'?scan'208";a="192640566"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 14:16:08 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 14:16:07 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 5 Nov 2025 14:16:07 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 5 Nov 2025 14:16:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=by95CB62PoWge1O+ozxmXHNqjzbdrcQED9PQm+CZhzUfpOYxR7aQvbS++y4V+mDEQBcDv/x+pI8sLM/ylR2964UQk2jqayJwDQ/urBeEhwwp87hZoVIsad7+DcLBmE3EFMosf/mVG+2tyV5L5rcOacZlE0KSgkT5Y3pquDd4S6w1MUb4Jnme4NaA/Squt4xyTu/lu195VZE6YRa5uhAHTb6adgvb29M/ZwaWZwT9ND1pMKz7PY0RA/+XvJCIwr2UnjmHHyN8pIUgkxsxSZWKEx+tWSj5BBAxr3N5hjCtCmcvEjuMm/1/bvvXKg2JJXTg1YFItmFgwGsa/D82kmNDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2O4vcHiO8/6Jclh0mmypRieUfYxzPqY4F+YqBfGxsA=;
 b=M98JhyJE3rHauxriBRvILbOs7GObaOQtDsBJg3tFB/WDGPhRCeKKsfNdYlDJG6HyBlIfXMfPhUGZUC1Lwk6fR3r7OjVfVhCV1qTahrSSVn709TXOzIp70iSBTA0pQudEYgP3Ne1w8JxteF8MLVVCLNXtjlHJjzkOHznDtVKXoN3ZsAIMeMLSoQ3otw61d0UkhHcmAYaeDZpTiBn/IdhkGXKRA2hf+1lyMgkF3ePpJUac4Tm2sKX2All3atRU9jwf8kkeMJDzZfROYa6cNEyAv7+uUb70DqjNlKxNsKU5ZURlKfqwBeTKSf6Ib2WK7Wzw8sVCm3kg6cyWMueJXglLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB8129.namprd11.prod.outlook.com (2603:10b6:8:183::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Wed, 5 Nov
 2025 22:16:00 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::81f7:c6c0:ca43:11c3%3]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 22:16:00 +0000
Message-ID: <d09ceb78-4f86-4114-8596-9b3d102de96b@intel.com>
Date: Wed, 5 Nov 2025 14:15:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: mana: Fix incorrect speed reported by
 debugfs
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <shradhagupta@linux.microsoft.com>,
	<ssengar@linux.microsoft.com>, <dipayanroy@linux.microsoft.com>,
	<shirazsaleem@microsoft.com>, <kotaranov@microsoft.com>,
	<longli@microsoft.com>, <linux-hyperv@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1762369468-32570-1-git-send-email-ernis@linux.microsoft.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <1762369468-32570-1-git-send-email-ernis@linux.microsoft.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="------------Z3Zpa0dAhOo0qKYjYgmOGhLW"
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: caf540dc-7f94-41c5-95a9-08de1cb8e697
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXhlMTBWbTNYUVVJd3JPS0Npa0ZXUmx0N3EzdzlzUkh6Wktnam14aVQ1VXdZ?=
 =?utf-8?B?R3F6czc0S0tGUitDdklaTTBRVWZkbEd0cDk2UitsWk9MZk5tcnZ6NElDKy9O?=
 =?utf-8?B?bkV6SFlDYnRZSnR5QmVRTmZlYlVhSTlYQkU1eCtLR2xQdy9VTEdiaFBLTSs3?=
 =?utf-8?B?REFJcEEyd3ppSjNDclJTTm9ERERQR2cwZ3Q5cC9iSHdndUMxa0toeFJVWmZN?=
 =?utf-8?B?WEtoRVBIZHNMajRWa3gzUG95NlVMN3dkU3dYSGsvckVFMDhlVjlwa3VjQkRo?=
 =?utf-8?B?ejR6YUF6M0RmTDZZQjdQT2ovMG5YMUs1akZ4MFJPb0JLYXFyc3NTcTZOd3po?=
 =?utf-8?B?SFlySVZ0U2ZocjIxa1F6VlZrSUhMVjBvV3BLYStZSS85bk5EemxtZ1lyekxP?=
 =?utf-8?B?U2lrS3JFYWNYKzlxL1JrRjRvOUpuQng3MnFXQUJybGtMUFVzc2FMbHFJMHRI?=
 =?utf-8?B?Mmk3SGxoT0poeTlFOS9KN0lNTVRmeHpTNkJ2RmpMWWF0Z085YTNIeFRlYldl?=
 =?utf-8?B?L05wakJXRm5KeCtrMVRkRmw1dE9xUkpIK0I2NEY4OGxOUGw1QXRWZUlJWmtI?=
 =?utf-8?B?NUp6WE9iVWZBNTNWbUI1YVlQNkVvMlZMbWV4N2NMV0kvRGxtNUJodGFrQjdk?=
 =?utf-8?B?djlENklTSVFLY1AxeHNTWGN3dkpja1BkZVc0V1lIVVAza1ExSThybGFROG5a?=
 =?utf-8?B?emNBenhIVzY3eS85djJmUzhMRldaaXpQd1V4U2JJckMwY011aTcxcTBReGlD?=
 =?utf-8?B?WURVK1o2M0duS0NpamV0ZTNvcGpMS3ZlRGlaS0NOeUNoU3BrYUpXVG43Q0Ni?=
 =?utf-8?B?SU5yTWs5Ny9zOUlsVm02bVp2WmlYNnlaOHZOR0JhSklYcE1XUlFnWDZQM1dD?=
 =?utf-8?B?QjMwL2kvaHpWMzRXZmVzakJxOEVQblU4OXlQcS9rQXJqSUxyMDVwQ3NsNzcz?=
 =?utf-8?B?bzhzeXBLU0xzLzMxUXNyZWRQRXlDOHZJQzVxdFdPNHZycFV0L0VWUXg0eHoz?=
 =?utf-8?B?M2hVSjNRZkZBY09qTXo0cDQ4QkF0UFJHUUFQVmphZVNTZlNkUmErL0xkQzNo?=
 =?utf-8?B?QWVCOHVhWFByaTROREUwcHc1Rkg4Vyt1dWE2ZmptaG9Ka3R0bVJabUZETEdN?=
 =?utf-8?B?dXRvQW1kYkJpZDZkZWdId0xGNXFUUnlUdjE5cExHMElrejh5bDZISzgxSmtZ?=
 =?utf-8?B?L3d3U3dVSlBIVHlMZTVvNEFWeDljNWhSNlo4YStjZnQwWjl2akRCSFFDWGov?=
 =?utf-8?B?YXlkT090RDVoWWx5bW5MTEFQcVEzSVdpaVIwTlo3SjdyK3Qwdms2TW83N3ZP?=
 =?utf-8?B?QjZSRUNmd3JmdGQ2dnZ6aThpOXNKelRPMVRZRmc2cU52MDVrcjNPM3J1SlI4?=
 =?utf-8?B?ZVN3MUpNalk2SXdOdTJEcjFmZEM1UXdNbWIrNVFoTDBPdFZMaXJJd0JJOXRH?=
 =?utf-8?B?UkNjTjJiZzVkMm9WL1ZkSDBPNnMvR0pUVCtVYVFJTUlkd3NQckNXWHQ5SElW?=
 =?utf-8?B?ZkY1QXZuNisva3lsWStJYlBxUS90U3RGQUhNLzFVTStFd1gxWUhmYlB2SHVn?=
 =?utf-8?B?OTYvWnQzNmxhaXJUS0hacTB1dDd6SitzSE16c3pub0lPZmx5VVg5S2tjdlBl?=
 =?utf-8?B?d2VqR0FwbUtBV0JPTEpzVVlxOWFnNFNZWW1zRERBN0I5OEV0ZUFkMFdiQnhz?=
 =?utf-8?B?MEtzZGRFMFI1UWpVNFVNUzduMFcxbG9WOG9aODlCRGg3U1FmZjBWWHN2TXNu?=
 =?utf-8?B?RVlIMndYOGxtTU9KdEtIdlpQVjQyd0NCVnZRR0NQTHFMYmF2M0VaWlZoQW1C?=
 =?utf-8?B?a3M4RmtiU3hZaVEvclJadTFNODB6QzdtbTN3Q1R0SmlBazlZZVhEeEgxRHFL?=
 =?utf-8?B?bjdIOWVaSGkzL2xjY01DUC9pczB5YnZ2WFZZWWlaR1hwN0czWEM0WjZGR002?=
 =?utf-8?B?SkhlU1JFY2FPM3JzL1FidW9waU9qMjJ5bHJGWnM3NmRSa3FUN0VXNWZ1Tkxp?=
 =?utf-8?Q?sxR0CSc9YbV4gb09njQWqwk+ZpdNcU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVBuQytyejRvTUd3dmVkSi8yZDBLZ2VwNGhBN3lNS2d1RW5ZRGU2QVpCeU9o?=
 =?utf-8?B?dnZTNzhFek91RkIrQStqZElJTWpqdWhsU1dDdDRIeVdMdUM5M1dobFlNSzNH?=
 =?utf-8?B?dlZEbTdpOE5KUnQ4bGpIcEZrRDJXc05lb3RmVytZWGlCcUxlNTgydzJVcURq?=
 =?utf-8?B?TnNVcDZ4VkhrdDljcTZ2a3VrYzVLL3VXS0Y0WDhuelUzeFlIeFpYTUFwU1BP?=
 =?utf-8?B?b3IyZWZoR3pvYkRGZUN6TWxVcGZzR2QrajIyWGRiNnI1Wmo3NzlYUDNLb25U?=
 =?utf-8?B?OXk5Y3NXYmRTclYzUllLSEdxMjRWaThiNzd0Ty8yKy9zc0U5NGI3eTdIZjVu?=
 =?utf-8?B?YmQ1SytHaHJxT2cyWmZmOXUySXhHSzJSUG5YMjNWYXFCYWI2YUc3N1hLSHpm?=
 =?utf-8?B?cjFwVlIxR3hyVDhMSjlJTmpydlA1OWdmKzZiOEpzVUtwa09sZmE3andtR0gr?=
 =?utf-8?B?UkhrZ3I0cXNtektDVU9Sb0Z0QnROTFdBNzhEc2d0THRhbW9aUWZ6Q3hDYUpP?=
 =?utf-8?B?RXIvK3NnaE1QczdNV05XMTBkazJYU0hjWUM1NGpneElrTm1QbkNQOFdOY016?=
 =?utf-8?B?Y09IRGUzays0anFVWGcvOGMreTB6UGRLdG1iVUlzUkY3WDNwdWZHODZuMmg3?=
 =?utf-8?B?bWIwK0ZHNlJSS2tnU1pnMTN5UlJxbDRGMTg0TEVRbnFTWHdGV29CZnR1RFJ1?=
 =?utf-8?B?ZTgxWUNFZ2dkRU1yWTJFMW5ndmJXd2pMZVVyWTJyeVdPdDFmRTk3RXM0bWtC?=
 =?utf-8?B?b29tWDRrbWlPb2hDOWpSbWluLzlHNkZzc2ZCZld6NnpiaW4wR3kwcjZJZkw2?=
 =?utf-8?B?UHlnQ1FCNXhtVGtiUnB5UmJzc25MMlBCT1dVcjBDSlhGbldwV3V6cFdYSUxP?=
 =?utf-8?B?bE9SRlpvdEkzbEY4U3lhOXN3aytBQnJycWh1QzN6RDlScnp3K0VuWU42b1dn?=
 =?utf-8?B?ZjFRQ2FQNlBNd0RiWEtxbUY2eGdUcFQ5WEo1VEJFMm5mZUd2b1Y1WGN2dXl0?=
 =?utf-8?B?bXFXRjZIblJJTjVPZmJhU0R2YkxJQ3lDUldCalV6aFQ1K1ZUYmNzN2dNTlFE?=
 =?utf-8?B?WHNBdXFrK2s4MkErbkwzVXdsY05mYnQ2bk5KanBxMUpjTTlxbUpIY3o1RXgw?=
 =?utf-8?B?VzhOZEVueFh6Qk9JVk05aFZJQ013eDZFbkEydHRvSFNCVnVSalhNVjFJcmty?=
 =?utf-8?B?VEYzVU1mSGRzMlEwU3RkTW9iNmIweWFIVmxNR05neDlObU9rRFptZ0JhNW1o?=
 =?utf-8?B?ejRkMlJwTDc2Z2ZLbEhmNWdRVlZoVnNOc3BJRk5mTFRLTHVLbnFVbmp5Tnp0?=
 =?utf-8?B?ZTB3dXNoTjUwYVZBU3hYbjg0Q1RFeEgrVFdXekNXUGpha2JHeGNndWZHcGZO?=
 =?utf-8?B?OVh0NUl0emVxUEhhSDJPM0hMTEUraGhabjRNZ0dGWUlvTE9jbHhZRDF5QWVx?=
 =?utf-8?B?a3BkdEZqVVArTVIwM2NSY1JTWGlsYnpBWjlVS0RYOUhETWkxVmErWG84UHVE?=
 =?utf-8?B?UDJDOFJ1Z3AvYnNPNmdTQThGcTVoOUMyVm9KaUxONVRGMTdwbktydEI2czZ3?=
 =?utf-8?B?aVVlTHN2N1Jnc2RrNk11aEFqeHZTNDVZZEZNY0JZcHc2eFdmM2QwaXVMUGhN?=
 =?utf-8?B?OEZJTExJM1Nzcm5USmJKVmdsSXcxV2dvckdiTklMUDk0ZHJUeVZiSUpuNjlv?=
 =?utf-8?B?SnA5b3JtUXMzU08wSkMxOGpzdit0VkduUnN4d2dvQ1N0VXdWYUpVb1BJTHR4?=
 =?utf-8?B?SWVVTjBEYk1maEVWMVdkbzNMMTJkV09jSk1Xb3ZYelFBdWx4bEg2ZXQxc0pE?=
 =?utf-8?B?c3ZneGVZdEt2NmdvbWVqeDJNU2Y5Y1VGaEZaSlVOTU9FeHRNS0k0NCtWUFdV?=
 =?utf-8?B?ZUZscE5ocFhEUlp3UzhMQjNuQU5McVJNdTlrcytMT3ZsMTl1MkdRVXcxS1hn?=
 =?utf-8?B?K1FYM1ljRERPY3lyMHI2TTZTZkczWDJTVkVhVUJzTlFkL1Q1dGYxaFF6UDd1?=
 =?utf-8?B?c25PMllQeElHU0ZwZkVzcFVuUHNlOVQ4Y3RlOW1uamk1VmpJQkVmL0xlM1FB?=
 =?utf-8?B?RHJnR3JmMmh5VmJqUVZpQmVaRTl6Q2JoOFJuWEtNcXhGU3FNQXRTeENENEZx?=
 =?utf-8?B?SVhKeHVCemJPc1JNYjVMVFphcEVRK3ozdzRsQXZTcWgzKzBHU3ZpRVJBMnlx?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: caf540dc-7f94-41c5-95a9-08de1cb8e697
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 22:16:00.2849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Djwd6/gCJ/JPolKwShPt8XqrmFTg1SyO03xKzux7XhIwKNz0n682XdYXLjVPGuLZeWTpiePiy/FK33DfpXS8HCtajhHNMa1Xzk5zIxU7O2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8129
X-OriginatorOrg: intel.com

--------------Z3Zpa0dAhOo0qKYjYgmOGhLW
Content-Type: multipart/mixed; boundary="------------soxuG2T5mjm0zQq3V4Mw2Vdu";
 protected-headers="v1"
Message-ID: <d09ceb78-4f86-4114-8596-9b3d102de96b@intel.com>
Date: Wed, 5 Nov 2025 14:15:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: mana: Fix incorrect speed reported by
 debugfs
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, kotaranov@microsoft.com, longli@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1762369468-32570-1-git-send-email-ernis@linux.microsoft.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
Autocrypt: addr=jacob.e.keller@intel.com; keydata=
 xjMEaFx9ShYJKwYBBAHaRw8BAQdAE+TQsi9s60VNWijGeBIKU6hsXLwMt/JY9ni1wnsVd7nN
 J0phY29iIEtlbGxlciA8amFjb2IuZS5rZWxsZXJAaW50ZWwuY29tPsKTBBMWCgA7FiEEIEBU
 qdczkFYq7EMeapZdPm8PKOgFAmhcfUoCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AA
 CgkQapZdPm8PKOiZAAEA4UV0uM2PhFAw+tlK81gP+fgRqBVYlhmMyroXadv0lH4BAIf4jLxI
 UPEL4+zzp4ekaw8IyFz+mRMUBaS2l+cpoBUBzjgEaFx9ShIKKwYBBAGXVQEFAQEHQF386lYe
 MPZBiQHGXwjbBWS5OMBems5rgajcBMKc4W4aAwEIB8J4BBgWCgAgFiEEIEBUqdczkFYq7EMe
 apZdPm8PKOgFAmhcfUoCGwwACgkQapZdPm8PKOjbUQD+MsPBANqBUiNt+7w0dC73R6UcQzbg
 cFx4Yvms6cJjeD4BAKf193xbq7W3T7r9BdfTw6HRFYDiHXgkyoc/2Q4/T+8H
In-Reply-To: <1762369468-32570-1-git-send-email-ernis@linux.microsoft.com>

--------------soxuG2T5mjm0zQq3V4Mw2Vdu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/5/2025 11:04 AM, Erni Sri Satya Vennela wrote:
> Once the netshaper is created for MANA, the current bandwidth
> is reported in debugfs like this:
>=20
> $ sudo ./tools/net/ynl/pyynl/cli.py \
>   --spec Documentation/netlink/specs/net_shaper.yaml \
>   --do set \
>   --json '{"ifindex":'3',
>            "handle":{ "scope": "netdev", "id":'1' },
>            "bw-max": 200000000 }'
> None
>=20
> $ sudo cat /sys/kernel/debug/mana/1/vport0/current_speed
> 200
>=20
> After the shaper  is deleted, it is expected to report
> the maximum speed supported by the SKU. But currently it is
> reporting 0, which is incorrect.
>=20
> Fix this inconsistency, by resetting apc->speed to apc->max_speed
> during deletion of the shaper object. This will improve
> readability and debuggability.
>=20
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Changes in v3:
> * Remove Fixes tag.> Changes in v2:
> * Add Fixes tag.
> ---
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/ne=
t/ethernet/microsoft/mana/mana_en.c
> index 0142fd98392c..9d56bfefd755 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -814,7 +814,7 @@ static int mana_shaper_del(struct net_shaper_bindin=
g *binding,
>  		/* Reset mana port context parameters */
>  		apc->handle.id =3D 0;
>  		apc->handle.scope =3D NET_SHAPER_SCOPE_UNSPEC;
> -		apc->speed =3D 0;
> +		apc->speed =3D apc->max_speed;
>  	}
> =20
>  	return err;


--------------soxuG2T5mjm0zQq3V4Mw2Vdu--

--------------Z3Zpa0dAhOo0qKYjYgmOGhLW
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnoEABYIACMWIQQgQFSp1zOQVirsQx5qll0+bw8o6AUCaQvMngUDAAAAAAAKCRBqll0+bw8o6MUS
AP9f+WO6RGjfqCeor6Go/m3c4xR6AxyIA8BAbWy2IIZn7gD48/LqOTT9RVftqe4mJBuoUdfOmSix
sNE5RLcJuVpOCg==
=WZWa
-----END PGP SIGNATURE-----

--------------Z3Zpa0dAhOo0qKYjYgmOGhLW--

