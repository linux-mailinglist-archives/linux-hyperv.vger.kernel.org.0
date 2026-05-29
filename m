Return-Path: <linux-hyperv+bounces-11386-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID//Ct0dGmqx1ggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11386-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 01:14:37 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70915609AA4
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 May 2026 01:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8504C3020D4B
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC28E377023;
	Fri, 29 May 2026 23:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DXWRb0Y0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52C36C5BB;
	Fri, 29 May 2026 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096472; cv=fail; b=PnregR6MRWQIoFR0In8C0F2PN1y9BsGtCXuPU0zTpZ9kE17DdH6MOp+psOAWX5HSOSD8weNTg/rbH7akbE/5n66zomjnwGVCLvwFL4Cd/QVtJNSwhm9lbqXTRb/TagwrahPnOJPYQdHzUThkRo6dind/TBFd3WLQwz8K36EM0W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096472; c=relaxed/simple;
	bh=XchzmJQm4BqmVtE5JgJDMR/RLlEqAkd4P/eJbdaYmaQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nhBp6Ujc5QBma20rcllE6i1UqYkoiBhJCLFdrtatsfC2Jpfszs3zDr0P/R2aEtu0rdEOlG/W1qEF5gVtZyXUm+7/TmES+Yd66gSHUAcLtttMD/rA1SpN5NOOPhx2Zqx3/K0Po8/Jflv2ZqdM6/F/EAvzndzgjsIPgHvl5L5s+9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DXWRb0Y0; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780096470; x=1811632470;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=XchzmJQm4BqmVtE5JgJDMR/RLlEqAkd4P/eJbdaYmaQ=;
  b=DXWRb0Y0H0en+p766eHmpphttTxGWFQidqQQ8DGxjiDhKszlZ7uVa+Ic
   xFznvV5X3OOSyS3BfT2Iq6Jj+IBKoHVCV3qkTK0HeGACvn+mVu+CiX+mG
   Jm/Ux0nCy2RUVKg7w2IwreoBVXQ9jy1yxADpjm/29NkBT1dTbepTcvSBd
   Mv5ZicHTjiyJsS6U0ec+BxReJOVTh6qUXwPixnuLmhHf6eDIOv2E+C2yC
   mOCouWbV1RstwWyjkCsFbrFDD+6IJZ6u0BdBfzz8ymknc6Nz5UdZpkY1N
   13Jn6zghwPi2D6IQONPtPG4aDpqN5m5NDWgytuKTg38xOtQFnzFPH6gHw
   g==;
X-CSE-ConnectionGUID: o6RBBi/lQ76Y76QcNt4huQ==
X-CSE-MsgGUID: ucwOjacASuWRxsg7Lau3Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="92425123"
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="92425123"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 16:14:29 -0700
X-CSE-ConnectionGUID: kdcrpXI4RTOy0S1jLQ/KAA==
X-CSE-MsgGUID: ZLQRk26jRliispVhPdEURg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,176,1774335600"; 
   d="scan'208";a="266613982"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 16:14:28 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 16:14:28 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 16:14:28 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.63) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 16:14:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nePxTdmZImMKD7d7vBZ2hKcRfHzYmVqlaJMxORhu0VWSaeT3WANSokDZKLUOxeYUpqLVnSHSKM5QBjn04C5EiidqfQMceU2Mx+I5Uo3Q5+cLvfMP8pGe60kS/9QOZ27lkFt4X01KsjnuurODE/6Yp3lyrxf4RlDqMjgscXryY+QBQyMx297rXb4zFGhXBeNH1aTU7XoNZyLUsm02YpOgOcrmFJ24yyY55Cw/kY17CMyc5QliiXBnevM//uANWQ+xAP/jQ78L7TNabmjen/a1b/D9SyVM6cHls8HZHxKctPsXgd6LztZGIFXQe+JTWDcm16xvZ3EqiiERHGiMuZSsEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BEa0VpO/zsoiq3Mc5VCMY3u2kyRuK4GLegy8XIGz5Ac=;
 b=Z8EiFVbv7Ve5u3VkEU7gzHUUt8dipqrvLTwWEPAzZjp+qsA6jkTTaEc6gSfz2a2wEh+wgnW9Z3Thgrf6sPwQqFRT+RMh/WXPLtyiEx5ukzAeTVy/VwV/ebUXearo18EHjpqizhi6nvf1h226vYtjGy8pqnSRHMmDDexaGD4BhlyM9sOGlrMFMsG0FoeEv6FA+mKvqQ3L278NgQCrY2lukmQj1aw2MKFNDamGwgUrwt1Rk46i+CTRjl9EOwq0mzP63Ykp5oqrGyLSy39081rxIo6tjkl1U2yfTHIcaWxtKH5DeQ08/DWn0QD4bAhE1/MxT2jdNXece8w7Z7LCytAk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB9952.namprd11.prod.outlook.com (2603:10b6:510:3d5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 23:14:19 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 23:14:19 +0000
Message-ID: <e061a8ea-505a-41a3-8d24-9b34f1fb4528@intel.com>
Date: Fri, 29 May 2026 16:14:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: mana: Cache MANA_QUERY_LINK_CONFIG result
 to avoid repeated HWC queries
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, <kys@microsoft.com>,
	<haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
	<longli@microsoft.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<kotaranov@microsoft.com>, <horms@kernel.org>,
	<dipayanroy@linux.microsoft.com>, <kees@kernel.org>,
	<linux-hyperv@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
References: <20260528180757.1536640-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20260528180757.1536640-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: 06381b0c-2db3-4c55-9789-08debdd802ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|6133799003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PdJuqU3EU5rEgYY4CEPGwx4/j9UODPUT3uTpnssWshHkFPHXm0L0g3OsKyN6rnSPX2wDPn0DQoRJeLnCI1zDvrC9kvc7GB2DB51dnq3sTuKAAwpFJuTGde4ffwBXvMVb7NYBlsUCCkiNTi/rVf1dQeu8TFq3eKi0yiXcMAmUrnlk7PKHgvRgGaBelL8aAJiD5VemWSN5rqMFU6bmAsAM9F3DL9saBUuU1wEY9JjMpWMOKYq5Wum1kXSy2CRNqvMklh2EaJgIRwAcL/+uSyPuszYioysORXhdNnXWL3JtvpgpfTOEQG3+WlKeu1wklVKxIa594/aM++EsT2+QrTLfPHLL9jdG9wX5xLeQqA7YGiuKh0l1LI5XbDewebfJxBhbO3frIDpY2F4z175QNWO6ouIHsD5mburVS91j+GMAmdFs7T/tumgU7bgb2EpkkFd5VJ0NnzUxtGPYIm7XeI0dRetObRh9CK+KGa6tllCj9jJQyqG/B2tj5nKwrZiEdDr2ZeBMW2NUQ3aaTY0h74xHr7j3m4oYszIkCkN1Ns6fETQ5SWGeMc3KS/bDEhagSSK3fCbG7t/2VYj/FBnKQ9s7qYxRWwLile8Aseh446wxowc39okz+YMGBc3+P3Fcs/TSluljwcZTJsZfl9xvt2+g4FoNZ7MqePDud3WzqgcGEm3xXardfvhvf3xKtj/GypfvYw3W+anvVwplnnDwj6Gv+9nkYkO2UnAWskqpbEO9fo1r3g16SKS4i+G41XnijnNR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(6133799003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFVXKzJ0V242ZEw5REdaQnhjK25lSnBRTGcxUTE5cnZabDhFb2t6TDBmajZK?=
 =?utf-8?B?WFBPd2NpQTZqZ1VXTU13Ny9ONmFmQkFQZ1FjRmpwWlB0V3FsR2syWE01QTVs?=
 =?utf-8?B?RkZ1MFgwR3A2ZzNlMnNKQTdzMzVPNVFZb2pCRlhZZm1QMVlFMnVYMVF2eUtv?=
 =?utf-8?B?VVhibFNPbWo4Wi9JUm1BWWVlYThkVGVQVDBKWkY2YnAwSUFWdXJKdlBLbXNP?=
 =?utf-8?B?Tmx0SFh3Q1FmVUtYcWFnV29qSFErY3orbnhCd1k0WUhUa2tqUG40MG1ZVmFk?=
 =?utf-8?B?ZUdoTzFZcFZWbWdYQ3YyODg2NVFsRUNLY0xOQi94eWE0MUlNcGhpekpGalFC?=
 =?utf-8?B?cmM3bVk5NEpDYnJKRDJZUk1vU2IzdE9wRmZxUm1CTXBGRURGbWR6S3oxeE0x?=
 =?utf-8?B?bE5oQmUwMU0vSnVTWG9adks1ZXFUYU9sK2JQamowOElyaGpaZDVObncvbm91?=
 =?utf-8?B?NkVFUHpXR25MaTliSzJGaHlZUUZJRGdUd0NRUlJLOEJRK2ZhbkJpWjlUb1Zx?=
 =?utf-8?B?SlJKeUwrc2tWRFZTUVRYeXV3eWU4ZENsSDIvMmdqQWQxVElXQ1ltenBROXRQ?=
 =?utf-8?B?Ym5UdnJ5bENGZWV5ckNnRjZTVE9xNlBJQ1hmcHNpcEpaYU1TZGtVUDNwNThU?=
 =?utf-8?B?QStvZTJDMkIyd2JHM3B2SkRLbGRzUWJVWjB5QnM1UHNNWWt6c1ZwS0lTSWZK?=
 =?utf-8?B?UWw1T0pBVlNjN1BmNWs0cUhMY2JFZDRIMXZpKzBzaEhtQ3ZuR1djVXU5VVBO?=
 =?utf-8?B?Rkk0eWg5ZjQrSC9hVXNneHJPUEZCd2orVkdBbG5JeExTUHRYVFBDcUFLZnZU?=
 =?utf-8?B?a3lxam1TWjRzTkVSSDNPLzRveFBIN0NZZHMxNzJ0OFAvTnNGNS9rK1oyZVRn?=
 =?utf-8?B?M2RCM0toUFRmeDJqUVNBVWYvelNuajdMbUNLVVpuaGZzc21DS3E4cmIvV0dY?=
 =?utf-8?B?Mmc1L0x2NkFsTlRTYThwZTIvUnNidC8rQk5VR3FRbkxMV1lmSm1MNVFxQnhk?=
 =?utf-8?B?U1FMNmRPUmxLeFBLS1JlM0NmOWZMMUJLaG45R05FaDNURkUvRkZYLzFvblpL?=
 =?utf-8?B?ZmExU1ZWR1pOaUd3aHBQVis3Z2dtcTRiSXRZR0hFemJiZUkxdnNEQ24xYVlm?=
 =?utf-8?B?U3hZTmRaM2hnNHMvOUhqRFdocU12N3VFMVVJZ3RIMnFBVE1hZGs4VUFvcGVO?=
 =?utf-8?B?YVB5RHVMT3RQTXVTdVZRM3RGa0dFcDY1Q2dkWGRadmhGdHkyS1U1WlhUaUp2?=
 =?utf-8?B?NFlndFlKQUNtQThhZ0lQVnFQVjltU2c3NkFZOGU4NURoc1l5cXdSNmZKd0po?=
 =?utf-8?B?Mm9ZdHZSTmNGcW1LMHA4UW54dVVtdEZObGdsODVENGVEeFZyaElIdlFSbTEz?=
 =?utf-8?B?S0t5SzJLSnh4eExPSWVBcys1TW1zdHFIVkFWdWc5Tk9aM0k2dGJETERwTFNR?=
 =?utf-8?B?ak5RK09uR3kvTFJFNEhWRXNUY0lwSkJhZGJtYmtUU2VBWSt4Q1dodDhXWnE5?=
 =?utf-8?B?STFxc1M3VWVQQjQ2djdPZm1iNmtta0tNMDhTSzlVZ1FKL1ZmUGprWW4yaHcr?=
 =?utf-8?B?TDBHVFdCYW10K0kvOU1zNkovUVNqUkt1VTJ6MkZBaG1DdEl1R1lOOWZHYkFS?=
 =?utf-8?B?Nnh2VEJGWDNKUHIrNGV4UmFDY0JUcFRjdFlsVVZRcTVhdkhzcUp5ZDcvN2F5?=
 =?utf-8?B?dURKeDhZVWNaTGRTcWZPeExFQVppa1dpSTJWcjZ6bU5NQmJvUkRPbG8xZU9s?=
 =?utf-8?B?MFNDQnBuSW93dUhXQk1aTnNTUjRtcVVxZjFnK29hSXhXVlhTN2dYRkVEZ24x?=
 =?utf-8?B?LzRDSFY1a0hyWlVIMEJKems0QmhnWXhZYlFYaWxXWkprM2tVZUM1dTN4RFov?=
 =?utf-8?B?UEFFWmYrRXZFWmVNeU96WkZtTjVIMFI2QUdEVnZMbDhPVG1mNkEyUnFxQnZ6?=
 =?utf-8?B?L1VFMnhqRUJ5UWY1czhXeFpmaGRNeUhhT203VkYwaDJkYUp4cTV5b1ZFbjNQ?=
 =?utf-8?B?bjhBWHJoSkpxRFh5NlFudVRvK0Q4SjdBOWJMUXEvZG9Dd1JxbEJzaXRrYW1S?=
 =?utf-8?B?VktPYjBpVWlmT0wxcW1SRUZvanoxTkVFamhQblJ0dHpsekRBSEZib1lzNFVD?=
 =?utf-8?B?WnZJZ2dVbWFsbzVFbGhWczlkc0Ftc2FqODZzZWcvdjJWUVlsc09rditJNGFa?=
 =?utf-8?B?RGRjcmY0N3FLclY4REFzM1RHNDNqZ0toMW93d2ZPUFVzb25VeWROTEsrbmFv?=
 =?utf-8?B?NW8vMDM1OGJTaTJ3NkR3SU5aVzlPQlBWajRwMVh2RGQ3T3gwY01hb2RpSm9V?=
 =?utf-8?B?c21VWmZxOCtGajk4OEtnYTY4UW54YnFOVnc2K25wZmF1OUZCQnh1QT09?=
X-Exchange-RoutingPolicyChecked: ISfF+cMyNLTMRnvJh8ikwvqYBP1LY6Q+lFGW7hkouJMzzVRb57S9SDqeEyXQOhIDo9uVgQnzEEBTy7e1Q/+DCnZatxiskYWl/zaVkYczVslTnC6iYooaDOXp49ktXnR7aCs3DMeV86x42jN9m1Fryq3XoaEDel0KiGxf5+4mVpqV3vExrdL6XEtQv/JUSZg5UgCXd4jsaNKYSF6GOQBHNx06rNo97A7D2Ql2r3s8Bno8MnqV8dB0G0Co3hrRvZ084qo2mzP8/YBJOYfdNjCp6u0kZH0YNcIogORetjtG6qxJ+W/v9t1YXUr12HBhQfgoLAWIG5FjQ/HxnaFyYPXAsA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06381b0c-2db3-4c55-9789-08debdd802ef
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:14:19.4901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFoNSSQFW+gaLfiIFTgw32YBVC/WNQ8y2mAYXZ1W2X2mnElLvySFda8O7eRlVcJSSnUNkK2gzbOEW1vaf/BS91jkxNoU0gWjx36sQus4W34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9952
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11386-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 70915609AA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/2026 11:07 AM, Erni Sri Satya Vennela wrote:
> mana_query_link_cfg() sends an HWC command to firmware on every call,
> but the link speed and QoS values it returns only change when the
> driver explicitly calls mana_set_bw_clamp(). This function is called
> not only by userspace via ethtool get_link_ksettings, but also
> periodically by hv_netvsc through netvsc_get_link_ksettings and by
> the sysfs speed_show attribute via dev_attr_show, resulting in
> unnecessary HWC traffic every few minutes.
> 
> Add a link_cfg_error field to mana_port_context to cache the query
> result. The field uses three states: 1 (not yet queried, initial
> value set during mana_probe_port), 0 (success, speed/max_speed are
> valid), or a negative errno for permanent errors like -EOPNOTSUPP
> when the hardware does not support the command. Transient errors and
> qos_unconfigured responses are not cached so that subsequent calls
> will retry.
> 
> To prevent a concurrent mana_set_bw_clamp() from racing with an
> in-flight query and publishing stale pre-clamp speed/max_speed,
> serialize the firmware transaction and the cache update under a new
> per-port mutex (link_cfg_mutex). The mutex covers both the HWC
> request and the subsequent stores in mana_query_link_cfg(), and the
> HWC request and invalidation in mana_set_bw_clamp(). With this lock
> held, two queries can no longer interleave their speed/max_speed
> stores, and an invalidation can no longer slip in between a query's
> response and its publish.
> 
> Invalidate the cache inside mana_set_bw_clamp() on success, so all
> current and future callers that change the link configuration
> automatically trigger a fresh query on the next mana_query_link_cfg()
> call. Also reset link_cfg_error during resume in mana_probe() under
> link_cfg_mutex, so that any slow-path query already in flight cannot
> later store 0 and silently overwrite the post-resume invalidation.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

