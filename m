Return-Path: <linux-hyperv+bounces-6280-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE77B0954D
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jul 2025 21:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23113B1889
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Jul 2025 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DDA194A60;
	Thu, 17 Jul 2025 19:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy3PKuM2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A32222CB;
	Thu, 17 Jul 2025 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752782354; cv=fail; b=rElbSWemg1g6xAbCGTwLIVBXCON8EKyRkpocSJhxX1trccHI5j+hnn/7zIqfxv1M+APQCzhfRz9UWeatp+h4GxlHR0TifbjaYDZKzQOfY2nnhaD+Jpzd+k7KRC/InPlo25eVX9i4U3zLcJ5eqAL/sJQUMhNZk9YBZYMwP7yTf7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752782354; c=relaxed/simple;
	bh=cz/d0qULGrbQWkNvST2m2OUW9x0SW5MiBoG6GnIPbe4=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=CDU8fL6h3HNwdGelcCmSiNJzBda+XsUPWsZPwNhDhi5UDqXonUSdXvxpQLwFGAblO3xKmQuwiEbfqHFCpTDVj6cf6/D0/h01yXBGbRe4/ASyvtOzMqJsAwvlKggoJJbphY2D4di5yiGDRZvmqR6FDOCeg4SQLPYnYkW9lhTo7pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy3PKuM2; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752782352; x=1784318352;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=cz/d0qULGrbQWkNvST2m2OUW9x0SW5MiBoG6GnIPbe4=;
  b=Qy3PKuM2Uj52CxS1oFQtCKvaDmgquDs6XOC+gjCAkXXxiL1UodBsezT4
   H5DgDpjtDHEHiptEGRu6sRBUlcxKUwwpmJXPCRbrVsDnhqHvQOH1c0ood
   1x+jnIK3E8Mn0BCVyC9z891FAyfZa3bLO7Y1BMN/sYwns1e42I73kmVuf
   hxidU1siaLluL7D9NPZ4oxtyMo9tiL4O+SO6BvS4IVNaX7JpO2L9UQGZK
   Z/xMB83Yfi4f4xGUvFLNcxPTYBBYsMXWXHt5fbUVurdGl1Agln29NVLAJ
   0ARShB3h27nHJ56jA3ZW85TPKTI0HzsXQQjji4LW17SF7mi+vGUKX3ryY
   A==;
X-CSE-ConnectionGUID: x4S5JVi0R8qwEf19V7inoQ==
X-CSE-MsgGUID: Bq+tGSL7QLGSdZ8jf9TtNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="66141012"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="66141012"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 12:59:12 -0700
X-CSE-ConnectionGUID: RNwCQCg8R8m0uK6tiGxc2w==
X-CSE-MsgGUID: l7zvMHsSQZSO+Cf+bTJ0BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="157687579"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 12:59:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 12:59:11 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Thu, 17 Jul 2025 12:59:11 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (40.107.102.78)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Thu, 17 Jul 2025 12:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cr25rlUt/agxXItZ9dxgPykIjOnoJvwR4IdUr+7g4pef5/LbtBr50M8a/cG0KhDVPLBx+SCgdxfYkduTvNgCHdQGOXB9XQKKIg14eyO1lfrWYZRMTgDKwr7FdKOhFkZS/5KRMWadAb38NjjyNI6p7rNxfMuhnksbBIikGhnFpCP3466wKaqjRE+zLtJBhQim01GWbSrlKowV9go5oqu6e5xiOCeagaHtoUAgjQML/RxNnRUBxR/DG3mGtdoLpXmJRJgSZWi4TRvyVEj6Q3UpENGMzzOpe4sSXkGN9pX4czLt4TE4OwJH7EOUWa/2/7FvHq/upEYoQS+QvfHRzukNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ll3uJAjjWFyq1J6wRo5IXPEuTH/aMS+aokpU14VgV0=;
 b=rP3zwlAFKwtq6GMPplU1Cj8WJZaqmnVqiDiRohk3km/vbY5HOKhal6swyHO6x/RS3imsX9ehkLF+MQsQML1hhonQGlfHmKPiR3yeIqJoZY0AKyS6wIPbpr/7qZgE2kaFLFM5IlxQZ+pK1MQQNbgO1137ENQCXsTC9IOp0oDSxqse0a5mmVWbsVCV7DL7HYrgUoCQmEWJ8jXqLkTHN6W+asafCcoUO/LqXOU2lo/3LRM0wOrCyNODYv8v0TGCoWG88sLJu2o/sUoeHGhitP5iYDpUitFTsFvlrQsfda1YDzJiWjkGre/xqqwbrXkArhCBj5TpiyVwGVykRXJ6/ldfvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM3PPF777B3455C.namprd11.prod.outlook.com (2603:10b6:f:fc00::f2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 17 Jul
 2025 19:59:07 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Thu, 17 Jul 2025
 19:59:07 +0000
From: <dan.j.williams@intel.com>
Date: Thu, 17 Jul 2025 12:59:05 -0700
To: Michael Kelley <mhklinux@outlook.com>, Dan Williams
	<dan.j.williams@intel.com>, "bhelgaas@google.com" <bhelgaas@google.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "lukas@wunner.de"
	<lukas@wunner.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, "Wei
 Liu" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "open
 list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>
Message-ID: <68795609847f7_137e6b100d8@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <SN6PR02MB4157ADD06608EFE00B86A3F7D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250716160835.680486-1-dan.j.williams@intel.com>
 <20250716160835.680486-3-dan.j.williams@intel.com>
 <SN6PR02MB4157ADD06608EFE00B86A3F7D451A@SN6PR02MB4157.namprd02.prod.outlook.com>
Subject: RE: [PATCH 2/3] PCI: Enable host bridge emulation for
 PCI_DOMAINS_GENERIC platforms
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM3PPF777B3455C:EE_
X-MS-Office365-Filtering-Correlation-Id: cf66b2c1-3d08-41a1-8a61-08ddc56c635e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0RId1VhMlRJWCtjR0pRVTVkekp5YUV1TDVnVVg2Q1BXSDdnZlBhd0hzRHlF?=
 =?utf-8?B?eFU1WWs5KzFpSWo1MVozb0VRV29jdmFXdnlKSHZucU05NTZJVm8rb3g5Wjho?=
 =?utf-8?B?Q2RqLzdudGtYUTZmdkl5UENjWmYwNWZkUkw4N2U1cVIvRktzOG96ZEQzdzZK?=
 =?utf-8?B?ZnhONEQ3MU5pL0llelJTMm4vdDg0SG12UC9XeEVBOEtPbEoyd0I5Z2QrZGpH?=
 =?utf-8?B?SDV3bnZLMStXNm5qSWp5MHpsOXpiQ2ZoV3A1amp2OGlHL2JSdFRINUJPQlJ2?=
 =?utf-8?B?VHpZZGoweWozeWl6VEVycmxXSzdYam0xSHhHRUhodVJpR2ZLTWFlUHA1MVpn?=
 =?utf-8?B?SHlTRFMrU3pWWFlab1daNWNoOFFWRFlPYkIxalhJWGlzQlQzT1JQSkdLZ293?=
 =?utf-8?B?WURPMzROeFl1ano0N1U3YTkzN3FnbDM1QjA2VGR3ZXJNRWRRcGdWNWt3YlRX?=
 =?utf-8?B?QmlydkNhdHJZSTJRNGtrVXhOeklBY0llTG5pM3VtbEVnVWQxejJJSjVrQ3gz?=
 =?utf-8?B?cnVJYVB5aEZGSkY1bkRhSXJhSWE0MEg2RWxRVVppMzdCTzRxQ2RYSitLT2xK?=
 =?utf-8?B?cjhoNmJXdElaUWRVc28wZXZFaE1Pb1ViMHhQZ2l0dytrTUVFQzY5MHhNYzRr?=
 =?utf-8?B?UHhLWXg3bG1UZkZqTGJTY0hCYVhYZFlYaVNKZmNNSUdQWTliVSszcCsyUlJ1?=
 =?utf-8?B?ajVNS09pT1o4aXhlVzNWbDlaNERZYkxBNElvUENzY1RKdjVtYmpTVS9CNWZK?=
 =?utf-8?B?VG4zY3B4OXRVeDdvVG1QNTRIM2tmMGhyMDU1Qk0xTTM1RFE1Tmt6eDhNWFc4?=
 =?utf-8?B?K0QrOHVzc2tZWmVoVGpCOTduMnJiRzJzZnhmdHhTUldxbWRNYXBsd2QwdndI?=
 =?utf-8?B?bU5nWWVSZWgwS0w3N3c2aWx5WStTL3N0YWpqdHhzbDl2Mis2bG02S3BDeE5h?=
 =?utf-8?B?T2pBMHg3OGNac1RUdDVCWE9pV1NYMTE1cWtoZGppSUFvanFreFoxTnJyQng4?=
 =?utf-8?B?RElCU1lGU0YxMUw3aklZN1E0TXQ2blNvK0ZFNXRObnhLOFhmUFJvTU5nTW93?=
 =?utf-8?B?cEhqSG5pam9QRXl0Z2tUQ0w3cXBub0J3OUNOeVhDQWZHejNKSXF4VjQ1dnZ0?=
 =?utf-8?B?WUhVK3ZrU2RSWTcwRGRVZTAySGdkcU9xbVFQMjdlZ0FFeitlcTJ0L3ZRSTJ4?=
 =?utf-8?B?NGFPcG5rYWd3cE5mZjd0QlB6aUdkbUE4QXJoSU85azJPMngxdWdoWUVEMXhX?=
 =?utf-8?B?aTNqNndORStXa1ludlRvYmpPdm94NlhjS3RrdlI2QUpJT2k2U0UwZFlYRXM3?=
 =?utf-8?B?YldPQTE0U1NSVlVRNWlibi95ZGhtY0VBaFYvdGcyRjNuNEVQSFhqd0RJQlFS?=
 =?utf-8?B?UFppMFR6WU9nVE5ORG0xRkFuTHQ5U2hjNHBUeWF0a1lZbDArd24xOG1GNmFF?=
 =?utf-8?B?dTl1b2o4RWtiOWd5SXRMNGZHcDlCdHlPT0lBZXgvNm5leXVyNk1CNDk3RUt4?=
 =?utf-8?B?OFdmY0RHOU5ycDFLbkUwY2FRWHFBVjZXT3JKN1g0aFlSeWJXbkhMaHdtSXVL?=
 =?utf-8?B?K1REZ2hQeXFEcGlXMUwxa3F4OFdPWFlaZ1hEbW5vZ2NUcGd5NHhaMEc4MGgz?=
 =?utf-8?B?c255Tzltck9hMGhhOGp4UnZ6ZVptaWxyZXVHY0JDTXlROHpVRkl0UkpvTDhX?=
 =?utf-8?B?ZXpSbVFxSmdyYWZYK09QdzFvazNCbFIwL25INDRNSEtDbTErczkrNzFSaDhH?=
 =?utf-8?B?Q3pwdU1QZWc4M0J0ak4vdkZyZTQyR1hpeVRCTzRrSnhXSTJQWjcvWkFBd0M3?=
 =?utf-8?B?VmFFeHN4aEFLQ29LS29FNzdaWVFFRzA0ZXZvQ05JR1FJRnZScUVRNHRNV1FW?=
 =?utf-8?B?V1ZHd2NZNkszUnl5cXlkQmxteEhYS2xmQUt0YUp5bWlFTlJjZUllaDF1N1NY?=
 =?utf-8?Q?GFYOfgn6fqw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGtodlh6NHpkejZqK3VNRlJPK01GeW94YlYxYzJRZEd1SUZXM2RMV1c2d0w2?=
 =?utf-8?B?cThiaGhZRjYyQkFUKzhXQTdkRERQZm1YQ3E4R0o5c1MyblBRNVFlNk03OE05?=
 =?utf-8?B?UXhRYXp3RXdDSmphc3hleDBIdXdzeGpjZVNldXdYTk5wTG10UW50c0ZKTE95?=
 =?utf-8?B?dnVzSmx3N0gwOW5pZCtyRk1SZTkvdDNIZ3lnUjNuTUJoM1FQOWJieUd1Ujdu?=
 =?utf-8?B?R0xLaDI4RSs4WUdmS3JDam80a1FQK0h2OUpjZnhGc0tWZlgyT1BzSjFKbnRN?=
 =?utf-8?B?T1ZKRkhycDVZemVXNDdIL3VEYkZGUm5tODVOWEFPU2xXaUYrN0RzZTdBZWh5?=
 =?utf-8?B?RmZvWlVQMUttOXhCVjFMV1pBZ0owc3Q2NHI1YXV2b0J6eDRIWnkySHhNblI3?=
 =?utf-8?B?ZFFGRTRGV0RQTVl6aklDR1FtNlN6YjgxZ2VOV1hPR1ZCTHBTc2xGc2dPUGxM?=
 =?utf-8?B?ai9hZHFNOVc2TXFGalVGaDNnVUZMazk4Ujc4aGZNSkUvSzlKZ2VhSkc5Y2x0?=
 =?utf-8?B?aEwvUlBSUGxyeGtpWUFlMTMzY01DNTV2NDMySStqbnZWM3grZys3MFpKWHV2?=
 =?utf-8?B?bVNqQit1M0V5a3QzcThzcE9YYTNQcXhtS0sxS2RHYnlNV3RMYVJzUU04OUxQ?=
 =?utf-8?B?RDlvcFRMVDhUMlRUR0doUkpRS2ltRjdTVnRidjF3ZE5uYWE5S3BqWTJPSmdP?=
 =?utf-8?B?bTRISlR3UnNoaVdpRUJJcmZmZzVTNHB0bm5KdjVaQVZmS1E5b09MaGtpR0NC?=
 =?utf-8?B?SEQ2VW9lR011ZVpUb2xYZVFUMWxvK0hvQVd5d2dxQ2V5VHREeFRNOW9QTFhD?=
 =?utf-8?B?S3NPWTAveThya1gvbmI4eHlLS3R0TG8vN1FCNU1PajA0RklKSDczYXVub2JR?=
 =?utf-8?B?c0tWQUMrcDZBVm9PWWdJRGVwR29hcklpNlBueCtrL09YczQwZm5zNE9oMEE2?=
 =?utf-8?B?bTZ1dkJ5SzIxNG5FK1R6SE56NmZReUdxd2pWMS9QSC8xeXpMNFdaZmhlblFX?=
 =?utf-8?B?WmlmT3JLMUtBWnFGN0pYbG5SSzA3ZUJmUFJDajlHWE1HZzEvL0ZOMURxSnFY?=
 =?utf-8?B?RDY0WEJBKzhScUgxRGF0aUNlVXBXdTRjZkR2VXJRNDJHVE81SmFzWVpFWTZ5?=
 =?utf-8?B?MGlPVTNRV3hmRWF6S3VmVDVwUEVXZnZjbUZnZW9LMUJxb20wMVFRaDk5SjdH?=
 =?utf-8?B?aEZFVGlGZWpUeFNOeXdJZFVWdURtZVgxTS9aZEQxMDhYN29HT2E0cnZjTW1S?=
 =?utf-8?B?RWhnOHhVWXdXRmt0WFlycEFvUjVGWUFQZmpmWkZtTkJ5SXpDV1hFRFRnaXox?=
 =?utf-8?B?dHVRVCt1KzF0a0RneldpaVlCdXR0aSt2aW9ydVQ2TWxMbVU3SVU3N2lwc0Qx?=
 =?utf-8?B?eFNQMFFEdktnQXI3QU9sek00dWtwZXZOT29NeDJVN01RRWwxU0cwMWNVcXJa?=
 =?utf-8?B?ZldhdlNIKzkzTzRrMmlrVHlDWDZ6bTBBYzNIcXRDWGRBYXZPbU1Tc3d3Y0Zq?=
 =?utf-8?B?a29NR0JZZlR3RWtoamMzY3RDenlZTDhEbGtLZFBGSmp6bXltMjRQbzJHZHNM?=
 =?utf-8?B?NzFrdjh6MklPUjBjYnR0MmZDem5HSVVzK3NNU2xManNheXpiMkQ0MzFKazhy?=
 =?utf-8?B?anNWcWpUcjVpdnNNZHl4ckU0MGh2SnhCaTkvUG8wQlFxTDJSdnR4MW9wVU1H?=
 =?utf-8?B?aFp4clA5QjBKbERSa2MwR3AxWGo3TkJnTkVhcjdTcnJZYTJEWTk2QzB0NmpS?=
 =?utf-8?B?M243M1NJMkd2d1hCWXBCVzltaUFzL01CZnF0VEN6VnZYSEdTWnZnWThhUGl3?=
 =?utf-8?B?ckc0YUM4SnQ1RHR2MkFacWNlUDNNV2x2dDFQQU15blM2alpNTExQYmdFZ3dB?=
 =?utf-8?B?UUEvUkdFMVJmbnRZNUwvTWl5ZkU5T2xSby94ZXJSdEJFL2hzTHlkYXdNdjF6?=
 =?utf-8?B?RmtnWTJQeVh1Q0lGQ2pGU2NRRWZKZXh0T1hmMzBFcnBpOHU4UGxrbXBQbFRM?=
 =?utf-8?B?QWZxbUxuVU9NSnJxdFpBMmFweXNFTGMxZTBlbVhPNThTMVBSRWJVb0JJc1gr?=
 =?utf-8?B?TWdrL3JNOS80OGVSNTZuV0d2MktPOWJSblJrdmdaYjRtVDV1REVRajY4UjE4?=
 =?utf-8?B?TWJhWHlYalNJYkVCSzMxWVZ6Nmt6dFo1U3dhbnVzSHg0T2VXblNydW5HeUw3?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf66b2c1-3d08-41a1-8a61-08ddc56c635e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 19:59:07.2637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwB3ZCQ3Ba+UyUjzPP1eP6fTy/G8WR+GgSKB6EqUZqAXHlGOzEMEpZMfGr/Og3VvkK2NwIQRNcKNibsEHyRkBVymRoXEMQmw5D5EFtjdOOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF777B3455C
X-OriginatorOrg: intel.com

Michael Kelley wrote:
> From: Dan Williams <dan.j.williams@intel.com> Sent: Wednesday, July 16, 2025 9:09 AM

Thanks for taking a look Michael!

[..]
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index e9448d55113b..833ebf2d5213 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -6692,9 +6692,50 @@ static void pci_no_domains(void)
> >  #endif
> >  }
> > 
> > +#ifdef CONFIG_PCI_DOMAINS
> > +static DEFINE_IDA(pci_domain_nr_dynamic_ida);
> > +
> > +/*
> > + * Find a free domain_nr either allocated by pci_domain_nr_dynamic_ida or
> > + * fallback to the first free domain number above the last ACPI segment number.
> > + * Caller may have a specific domain number in mind, in which case try to
> > + * reserve it.
> > + *
> > + * Note that this allocation is freed by pci_release_host_bridge_dev().
> > + */
> > +int pci_bus_find_emul_domain_nr(int hint)
> > +{
> > +	if (hint >= 0) {
> > +		hint = ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
> > +				       GFP_KERNEL);
> 
> This almost preserves the existing functionality in pci-hyperv.c. But if the
> "hint" passed in is zero, current code in pci-hyperv.c treats that as a
> collision and allocates some other value. The special treatment of zero is
> necessary per the comment with the definition of HVPCI_DOM_INVALID.
> 
> I don't have an opinion on whether the code here should treat a "hint"
> of zero as invalid, or whether that should be handled in pci-hyperv.c.

Oh, I see what you are saying. I made the "hint == 0" case start working
where previously it should have failed. I feel like that's probably best
handled in pci-hyperv.c with something like the following which also
fixes up a regression I caused with @dom being unsigned:

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index cfe9806bdbe4..813757db98d1 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3642,9 +3642,9 @@ static int hv_pci_probe(struct hv_device *hdev,
 {
 	struct pci_host_bridge *bridge;
 	struct hv_pcibus_device *hbus;
-	u16 dom_req, dom;
+	int ret, dom = -EINVAL;
+	u16 dom_req;
 	char *name;
-	int ret;
 
 	bridge = devm_pci_alloc_host_bridge(&hdev->device, 0);
 	if (!bridge)
@@ -3673,7 +3673,8 @@ static int hv_pci_probe(struct hv_device *hdev,
 	 * collisions) in the same VM.
 	 */
 	dom_req = hdev->dev_instance.b[5] << 8 | hdev->dev_instance.b[4];
-	dom = pci_bus_find_emul_domain_nr(dom_req);
+	if (dom_req)
+		dom = pci_bus_find_emul_domain_nr(dom_req);
 
 	if (dom < 0) {
 		dev_err(&hdev->device,

> > +
> > +		if (hint >= 0)
> > +			return hint;
> > +	}
> > +
> > +	if (acpi_disabled)
> > +		return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
> > +
> > +	/*
> > +	 * Emulated domains start at 0x10000 to not clash with ACPI _SEG
> > +	 * domains.  Per ACPI r6.0, sec 6.5.6,  _SEG returns an integer, of
> > +	 * which the lower 16 bits are the PCI Segment Group (domain) number.
> > +	 * Other bits are currently reserved.
> > +	 */
> 
> Back in 2018 and 2019, the Microsoft Linux team encountered problems with
> PCI domain IDs that exceeded 0xFFFF. User space code, such as the Xorg X server,
> assumed PCI domain IDs were at most 16 bits, and retained only the low 16 bits
> if the value was larger. My memory of the details is vague, but I believe some
> or all of this behavior was tied to libpciaccess. As a result of these user space
> limitations, the pci-hyperv.c code made sure to not create any domain IDs
> larger than 0xFFFF. The problem was not just theoretical -- Microsoft had
> customers reporting issues due to the "32-bit domain ID problem" and the
> pci-hyperv.c code was updated to avoid it.
> 
> I don't have information on whether user space code has been fixed, or
> the extent to which such a fix has propagated into distro versions. At the
> least, a VM with old user space code might break if the kernel is upgraded
> to one with this patch. How do people see the risks now that it is 6 years
> later? I don't have enough data to make an assessment.

A couple observations:

- I think it would be reasonable to not fallback in the hint case with
  something like this:

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 833ebf2d5213..0bd2053dbe8a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6705,14 +6705,10 @@ static DEFINE_IDA(pci_domain_nr_dynamic_ida);
  */
 int pci_bus_find_emul_domain_nr(int hint)
 {
-	if (hint >= 0) {
-		hint = ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
+	if (hint >= 0)
+		return ida_alloc_range(&pci_domain_nr_dynamic_ida, hint, hint,
 				       GFP_KERNEL);
 
-		if (hint >= 0)
-			return hint;
-	}
-
 	if (acpi_disabled)
 		return ida_alloc(&pci_domain_nr_dynamic_ida, GFP_KERNEL);
 
- The VMD driver has been allocating 32-bit PCI domain numbers since
  v4.5 185a383ada2e ("x86/PCI: Add driver for Intel Volume Management
  Device (VMD)"). At a minimum if it is still a problem, it is a shared
  problem, but the significant deployment of VMD in the time likely
  indicates it is ok. If not, the above change at least makes the
  hyper-v case avoid 32-bit domain numbers.

