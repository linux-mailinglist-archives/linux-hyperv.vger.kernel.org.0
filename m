Return-Path: <linux-hyperv+bounces-2622-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C7493FC27
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jul 2024 19:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91941C224B1
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Jul 2024 17:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28B715EFD0;
	Mon, 29 Jul 2024 17:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NldPOGJx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8DD15EFC8
	for <linux-hyperv@vger.kernel.org>; Mon, 29 Jul 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273250; cv=fail; b=dSoCYWpM3bXSSiZZwhH/TJHHth3hlr6YzYans/h47ZnlP70SNCxXWMEPfIl0n5FELf+fxmZT1+O/L83NXDrqYg1AlqvkwQ6Kn8nCg+I1mBHlR+KL1ig69gql1rM0c7J0XUJ+gFXbaLvZwW1xfMsOKIeEVSruqijBfPqmc8CLeQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273250; c=relaxed/simple;
	bh=2ugqb5DPr1HDm1p/hmUCJb5gF3Tsmz3UZSCtZbCQ9vE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W7Z8PFpIkRjA1pWi2mbtM8qr26sb1cNO+/cJmhVNIPNY+XvePkF0UU5S+mKjWnFWwJ6i/EBdUNGNgik1di9Z7spFAxsbKuTWZA66sh2kExu98MZQf+q6MLsAqsix6W4O/3iNHEJKwfD9ScSEmncZ7ITqcIMr9LqX9ZsCZ22LKqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NldPOGJx; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273249; x=1753809249;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2ugqb5DPr1HDm1p/hmUCJb5gF3Tsmz3UZSCtZbCQ9vE=;
  b=NldPOGJxYXgrK3qs2zZ/q+eTMpOZHlDq7C7YYCZcTBfOSM8Wa7AEKqHr
   SqpLF0sFxpv4m+PqD4AdS30YJxCVWeipqiYxM2or2gLwzj+xw9pE1Fq0v
   ygFGks+8nq2hlnq1v7utbJcZ5z1mrIxELxYi4NcUw8fZqBnILB2EQKPsV
   bwuPJ5N2gjcI0XbHqByNbhMChesFFzp+6eqSN/JyBYX8V6uyVVPOCNMVr
   O7RTFI35w7clhruJGjaL04Ry851P2sTdEHCKtyh7M9x8MeMSAq3RpWNjl
   TVfxgzNd5kY1Py4/iXxxZyG6/1XKcd9dfpKR6zxpTVdDJ8+LXHjcb3Nux
   Q==;
X-CSE-ConnectionGUID: E1aEUaOBSfSzLWhG6DQHAg==
X-CSE-MsgGUID: BlcoBJUyR6OptlMxS5Xx6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="19746815"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="19746815"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:14:06 -0700
X-CSE-ConnectionGUID: jgRffD7+Sk6oXjveXsgNsA==
X-CSE-MsgGUID: 2ulxge8oQNCgCCwp9fEtsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="58834741"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jul 2024 10:14:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 10:14:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Jul 2024 10:14:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 29 Jul 2024 10:14:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 10:14:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylJoMQqbyoGa1lM+95mlpgVo9/KeejEdV7xoZgi8+jrJh3lfQCoKPS4bJFASqVGVBZ1VuDSgmOiq91ANgWON43di0iXDIyM1h4CLTEI5DMY9xivXYpcqsAxUU50ncNzz5VKizXZqVok95lqYPqj2fhPbdPsLmLLxlb4NBNIXBhrIw/TJOVia7vArO5PxLYZodhiXypfIPcULLSL3cmIuZmtKAoQoCxiNihmpbkh4ztg/NZecQxel55iiFg4NUrLSAj/OmihhzU/6FpUIXo7F91S7EXXk90t1hQ5GFw89idFghjElJtBvow2SqLFGuhyfHe/W5yJqX4mrTMa7fJnFdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ugqb5DPr1HDm1p/hmUCJb5gF3Tsmz3UZSCtZbCQ9vE=;
 b=g1qkwW84Ee4vfvY9+nqlodvbrlum1S6WzstzKgtDPRMZfWjV9VvJFjMOoLcbLnXsBX7P44pfnvk3Jk6E9DfSWqiacqcncDGuCdwYw7Xvn1iTsi1GUx/i7QK2CvyYw1fx4Dxn6SgR/VRP+24DPva4x+/Xsb405enNIMnkwY3GvH9z/mPdFdFllVDjrn9tGvhtpmUsDlcMbpYNvcN0gGHWZ/1x8EmuGcleGTpAkz6M7hKis8OZShvI4cstUfh3AcJtXSqgHzVx1L3rPaAZLZPDIQinjOO4zS/BZNq8HZ6+o4Qq2Bq8ykSG9nf3K/uqzgmM/lZB/OEfP+bKFcLXCupc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by BL3PR11MB6364.namprd11.prod.outlook.com (2603:10b6:208:3b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 17:13:56 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%4]) with mapi id 15.20.7807.009; Mon, 29 Jul 2024
 17:13:56 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [bug report] Drivers: hv: vmbus: Track decrypted status in
 vmbus_gpadl
Thread-Topic: [bug report] Drivers: hv: vmbus: Track decrypted status in
 vmbus_gpadl
Thread-Index: AQHa3+aZDHfn/zb91E+DRly4VUZI67IN9ZMA
Date: Mon, 29 Jul 2024 17:13:56 +0000
Message-ID: <28faaca970473bd942d820debcdc6d330b2d5da9.camel@intel.com>
References: <4036aa13-e8e1-413c-b0ad-5b82b3f2615d@stanley.mountain>
In-Reply-To: <4036aa13-e8e1-413c-b0ad-5b82b3f2615d@stanley.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|BL3PR11MB6364:EE_
x-ms-office365-filtering-correlation-id: 7059fb10-29c4-457c-1ca6-08dcaff1d44b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cU14bENuSHVBSmt2N0w3VmY4V0h3MGVzN3hBdUlLajFNZnhualZwemZHMnpj?=
 =?utf-8?B?ZUUzaENjenZmaXRVWHdhT2svaHBEUVVsRE1TN0dZN0dCREdZeHltWFZpWXda?=
 =?utf-8?B?NFo0ZDN5RGsrUGwzTHJMQTlsbitqajh2T2RWS2FNckpkcFFuNUhLck9OUmJQ?=
 =?utf-8?B?NzJORGJXWEYxRVIrTTVOS21nNW5kVzdqbnJ5SkZmNmgyK1FYZ050dk5Qcklm?=
 =?utf-8?B?QXBBc2VOZnlSb3hLV2lRV1E3SFVjWVFLbWwra0NsemNNYTZNVThucGRyN3Fx?=
 =?utf-8?B?YVdJVGxmNnlxK0JkeVZXU0FjaE53TWthdFBQM0d4Z1I4aWFmUlpNcFJWRzcx?=
 =?utf-8?B?TEVzZFhaNzB1ekRoRjh3a1p3RDRXcjNnTE9VSVk2VUEraHVPeWlVUWZPSXZM?=
 =?utf-8?B?cExzenRtMVZGQXRyYi9NR0Z6c0tXL2N1b1l3dHpMNTlUOGh0SDBKdVBJaHVH?=
 =?utf-8?B?Z0dhQTdkQkdOSmxLRC9mNm5IZGVoVlJ3U2tFbDJqTXIxbGZkanpwbTBMVUNT?=
 =?utf-8?B?OGNsZkF1Z2k0ZVZlN0ExbkJwQ0RSbXc2QmdlQjRwaDdHbjJIcGVjNjBwWEpR?=
 =?utf-8?B?eEZIS3hGaVVveURWb0JqWVdWVmRYZVVDemdmbmNwalpiT1NrdHFaWnpCR2tG?=
 =?utf-8?B?bFlJVE81OWFFVGJkQ0UvekQ0Z2l2SG1HN255YnN1OEtPSGJiVXl0VEVKOVVk?=
 =?utf-8?B?SjhaTXlCcWJVcUtRWUhTNzcvei9FUlBHMTZqRnlvN2tVQzRITURBUjJrT29V?=
 =?utf-8?B?S2o5emh3U2llSVVjbWFTSHVlRitldm10blhkS3lrQjI2a3RJOGZzWGpBSkZr?=
 =?utf-8?B?a3ExcXV2eWVBdi9MeXlXM0xSZVpVcmFDcGR4OTBxTHBtM2QzMnljNDhncUZX?=
 =?utf-8?B?R2h3ckV6ZVJNR1lvTE5la0NYa1Y2RWNtOGt4NGxyeFdtRlNqbHV0RzBZeTFs?=
 =?utf-8?B?ZzNWd2pTb3lINFhNdjFjY0VTWFladTllcXBhUlhuSXBNWnJOUlcra0hTY0xa?=
 =?utf-8?B?MXdxcFdpNGRtYTVGcS9GZ1VyVU00VGJwNTFmNklnd2xiVC9LOEpmN09hR1l3?=
 =?utf-8?B?bkxUcm1sSEpuUzhYSXAwWWpQWGxWcmVTODdMbkdMdktPYVd0eUJnRldCOVpU?=
 =?utf-8?B?aHRiNHpuZTRydHJzaFRlUnphMndJaVFXTGpsY29XaWEvdWEyQzV5QUdLa3RY?=
 =?utf-8?B?d3JqMmxWTUNMOTVkL3lueTBacXBKV2NoZ3ZJY0JjcXdtWlNiMnZhSk9VTlRz?=
 =?utf-8?B?Z04rKzAxb3FIa1pZanNxT2ZwRWgxd0RZc0pTaGEvUUpKSkZPdWpxQnJhWXVY?=
 =?utf-8?B?VDJhQjBlY0tlZjBucTZYZXdXQ3laTldBdDh6Z3A2Ull0UVFzYkN0a0wveGgw?=
 =?utf-8?B?T1ZkbnRSditnQWlXMm1xWFNGYjFOV0FGNkYwaHQyK2tPd3NIWmFUUnFEbitF?=
 =?utf-8?B?K050MDViMVpDMys3U1RWY0tWYzdhYkI0YzBJd3RaSjArSVlycFUvem1wM24r?=
 =?utf-8?B?TW16c1NvcE9uS2NRVzRCelo2OWhhMURXSWVVdkhOaEx2bWhMVTlPRkNsUzRU?=
 =?utf-8?B?T3hQN3lxMEFObExaR1FqMzRBQlhRWHlVaFJ5Ny9MbU9wTk9qdE5hSFZ5RkdI?=
 =?utf-8?B?bmc1UDZOLzM5NytkelNFTzNGdzZiUU1MbnphYjBTcGhmVHRZam0wUUxHVzR4?=
 =?utf-8?B?OUtTeUZQd2RTdEVUenNVTlBVamwzYk4waGx1RjhPZ1ZLSDJWc2lFY1kzdUU1?=
 =?utf-8?B?bG5HQm5saGthY3pJL3EvY3NqUVl0L0tjUGxKaytvb2kvcTBqL3QydktMekJ6?=
 =?utf-8?B?NnIyTEpuUStLUjQ0c2tPclVPRlZhR0RrUXdHSzFtN0hpaWFvYUdyNTl6U2t6?=
 =?utf-8?B?TklzN0dtYlArQUpka21vaWpBampHSDVwUXNaLzJpcVlmNVE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFRvb1h6MUVxRCtGU1VJUm5ZY0lyUDl6MUEzSzczLytJNUc4T1UxbERadTFw?=
 =?utf-8?B?NHlZS3Yvc3BRcUJRd1FuWm84WUNSNlVCekYzbFE4WE8rWmIrUGtmeWx6Y2xv?=
 =?utf-8?B?YzZSaUtjYlJ4a1hIcDRGTWhKaS83VUg1bytpM1k3MkZlSnBhd1FlQ2RNcGo3?=
 =?utf-8?B?NDFkRGhuNnNqNWgxeWNESTFHZ3BoUk9TRDFDZE5TanRBU1Y2VFNTMUhGY2xr?=
 =?utf-8?B?Y0FYU0E4dVZBRndINmUrR2FONDZDZzNVcXF6aTk1Y2lVVDlaaVdrRm5vck5F?=
 =?utf-8?B?OVBOeDU4OEx2U0c4anJJb1N3UGY3MHdOc2pCbWxsVzNaUkxOeEI4VStnT1Fq?=
 =?utf-8?B?Q2NVS0VNbmRTNTNnMEhUdFNoNXlKTUFuN1FqWGh3MFRPUnBOWkYvS1RJZ3R3?=
 =?utf-8?B?amVVV3ZmSXcxMlpiSUFoMWxKNCsyWHZJeUU1dXZiMHJocThoS1hVTmpJUjE0?=
 =?utf-8?B?U3lqSmQzeEdwMUplNnk2UzQvOFNBOEZxQkg5V2RIOGZ2aWxaTXUxM1o5a0ZH?=
 =?utf-8?B?SXFsSnJFbHVlK25yTmFiQjg5ekxLeXNON2k4MFRHRFlwTVR4K2lHK2crY0Iy?=
 =?utf-8?B?cDZnd05rWVhQaENSZ0V3UGNGL3drRWk1Y1p5ekRTbGU4eU9ONU05aU1JbFRT?=
 =?utf-8?B?WWFmaExING10SzVKL2RTU2JDdCtiR08ydmo3R1d4RmNERHUwTHNoZHd2N0lV?=
 =?utf-8?B?Szk3R2lDRTNTUmh3Um1EZ1IveW94VUpxaGtVSmdNS1FkVVFsOXBDcWhEbWxh?=
 =?utf-8?B?UEppU2JKZ0V6c2xzRnZXaGpOZmZISkJqWVlnWHhhSzdOc041UGVFL09VTzl6?=
 =?utf-8?B?cU5CTExzWWtIWE90R0w5Y0JiZXFuQzRmZWxYS2lZM2VNMklPenpqWWtuUFFS?=
 =?utf-8?B?SkkrR3QrY3RLUXdMVDhtVU1PWlpCQ0wzc0RDR2pWM3pBUERlMFRnTzR3OWhr?=
 =?utf-8?B?cERrMHErSmprTmpOeWlQd1BVOTVPWGd4WU9NUDc4cnc5K1RhWmJ1cFR5NmxT?=
 =?utf-8?B?TXZWWXk4WDBacTZzUTBZYWZRM2N6YWFIY3FIQWpzRmxrQ2JiVm1vZktBVUVQ?=
 =?utf-8?B?K1QrMmVUbkFIdGVMK3RxZWFEUWMweHE5QzFPWWt5UVAwYWhMVnNRYmxaeCtt?=
 =?utf-8?B?Ykk0YmRCeTV2UHE3VWE0ODdjV1JKMGxlcGZjMTZudk1Sd1E4dFIveFFDUGY4?=
 =?utf-8?B?dElDRWNPVlRZRDg0S3Q2Y3FvcitjSnc3cWpjNGpaN0VXMEZobE1ZcnlBclJl?=
 =?utf-8?B?RmgycUU0d2xHT2xMTG92Yld3c0RZTUNtZ0FxUjF0MGZVNTlwRVE2TFJKUzNQ?=
 =?utf-8?B?Znpzcms2RGZCU050UnFsOU9KMDFwMGlxcERDK2NhWXE1bUpCby8zYk1oSDdU?=
 =?utf-8?B?RGI3cXBEZGpDRytzYWRCR3dnT3dxZVhUZDY2M0RxYkJXWFY5NWZEYk1Wd1RJ?=
 =?utf-8?B?MTBNc2xHNmQ5WURueFhCbU1OclJBWGRuZnMrUDlZZFlQNHdmUFB4UnM2aENu?=
 =?utf-8?B?bGVidlBHOVdvUEVDRkQ0T0RkYm4waU10VWthdGpzMTd2Y3JVQTl0N0Noa2RL?=
 =?utf-8?B?Rms0YTA5SGo4T3VwTjBpQUdIN3AwWEZpVjArSVJHZlFKcElRZHg0UjRhZWdT?=
 =?utf-8?B?UnQ4dXhxVHF6ZFlRRklnVUJwbUdDZi9MU05mZGtkbXlkOGFFZHhGN2h6aFNL?=
 =?utf-8?B?bzI3QUN5M3VmYTY2THJKY0YvNzI0eFcrcnc5c25JbktnYTJRbGg0QVlRdUZx?=
 =?utf-8?B?UDRQZTN3aWZ0VE1EOHB0Z3RrZDZDM1NTanNqOVpwT3c1dEw3bnVrSGFMM0c2?=
 =?utf-8?B?ME9BTlYzZXFXK3NocDlnOU5jWCtOcjdoenlCSXJXRW10VWxSbzRrdzlVSnBh?=
 =?utf-8?B?QW0vdzRESmRFTForMm9TTFFxWW9mZTluVW5oR3pSUEsrQ05tdzZTTGlmWHNO?=
 =?utf-8?B?UUFZUXg4eEczUlNVY2JlOTBzWHQwWis0blIxNlhZNHlTVk9LVUVUY2x1R1dJ?=
 =?utf-8?B?dm9JdUhnK0hXak0za0lWQUVtUWxJVXRmTWlQQWNwRVBZRXF2ZndhS2pjRlhz?=
 =?utf-8?B?bFlPRERKMzZwMDl0aE0wUjdHaHFJY1RCRjVNbXZVYUxEZkhkckM3NUEyTnl5?=
 =?utf-8?B?Qno0REV3bkRGM2FpZTRNWWJmeHdON25xVHhaSVN0cEptSDVMYXNJR3JnSS94?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9CFA1D084F83644ADA9D2B4EC405337@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7059fb10-29c4-457c-1ca6-08dcaff1d44b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 17:13:56.2972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XL6JzoMz5Nph2/jZAHzgTL6vvwexlGekVEPkRQEZ+BpK5KaI35sr8LLAk9y/zjMKxCz4MbIlrNEDXJ62ut5tyBXbO/gb3SvAoNQqHR87qCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6364
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTA3LTI3IGF0IDAwOjMzIC0wNTAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+
IENvbW1pdCAyMTFmNTE0ZWJmMWUgKCJEcml2ZXJzOiBodjogdm1idXM6IFRyYWNrIGRlY3J5cHRl
ZCBzdGF0dXMgaW4KPiB2bWJ1c19ncGFkbCIpIGZyb20gTWFyIDExLCAyMDI0IChsaW51eC1uZXh0
KSwgbGVhZHMgdG8gdGhlIGZvbGxvd2luZwo+IFNtYXRjaCBzdGF0aWMgY2hlY2tlciB3YXJuaW5n
Ogo+IAo+IMKgwqDCoMKgwqDCoMKgwqBkcml2ZXJzL2h2L2NoYW5uZWwuYzo4NzAgdm1idXNfdGVh
cmRvd25fZ3BhZGwoKQo+IMKgwqDCoMKgwqDCoMKgwqB3YXJuOiBhc3NpZ25pbmcgc2lnbmVkIHRv
IHVuc2lnbmVkOiAnZ3BhZGwtPmRlY3J5cHRlZCA9IHJldCcgJ3MzMm1pbi0KPiBzMzJtYXgnCj4g
Cj4gZHJpdmVycy9odi9jaGFubmVsLmMKPiDCoMKgwqAgODYwwqDCoMKgwqDCoMKgwqDCoCBsaXN0
X2RlbCgmaW5mby0+bXNnbGlzdGVudHJ5KTsKPiDCoMKgwqAgODYxwqDCoMKgwqDCoMKgwqDCoCBz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZ2bWJ1c19jb25uZWN0aW9uLmNoYW5uZWxtc2dfbG9jaywK
PiBmbGFncyk7Cj4gwqDCoMKgIDg2MiAKPiDCoMKgwqAgODYzwqDCoMKgwqDCoMKgwqDCoCBrZnJl
ZShpbmZvKTsKPiDCoMKgwqAgODY0IAo+IMKgwqDCoCA4NjXCoMKgwqDCoMKgwqDCoMKgIHJldCA9
IHNldF9tZW1vcnlfZW5jcnlwdGVkKCh1bnNpZ25lZCBsb25nKWdwYWRsLT5idWZmZXIsCj4gwqDC
oMKgIDg2NsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgUEZOX1VQKGdwYWRsLT5zaXplKSk7Cj4gwqDCoMKgIDg2N8Kg
wqDCoMKgwqDCoMKgwqAgaWYgKHJldCkKPiDCoMKgwqAgODY4wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgcHJfd2FybigiRmFpbCB0byBzZXQgbWVtIGhvc3QgdmlzaWJpbGl0eSBpbiBH
UEFETAo+IHRlYXJkb3duICVkLlxuIiwgcmV0KTsKPiDCoMKgwqAgODY5IAo+IC0tPiA4NzDCoMKg
wqDCoMKgwqDCoMKgIGdwYWRsLT5kZWNyeXB0ZWQgPSByZXQ7Cj4gCj4gcmV0IGlzIGVycm9yIGNv
ZGVzIGJ1dCAtPmRlY3J5cHRlZCBpcyBib29sLsKgIFNvIGVycm9yIGNvZGVzIG1lYW4gZGVjcnlw
dGVkIGlzCj4gdHJ1ZS4KCklmIGl0IGZhaWxzLCB3ZSBuZWVkIHRvIGFzc3VtZSB0aGF0IHNvbWUg
b2YgdGhlIGJ1ZmZlciBjb3VsZCBzdGlsbCBiZSBkZWNyeXB0ZWQsCnNvIHNob3VsZCBoYXZlIGRl
Y3J5cHRlZCA9IHRydWUuIE9ubHkgaWYgaXQgaXMgc3VjY2Vzc2Z1bCAocmV0ID09IDApIHNob3Vs
ZCB3ZQpoYXZlIGRlY3J5cHRlZCA9IGZhbHNlLgoKU28gSSB0aGluayBpdCBpcyBmdW5jdGlvbmFs
bHkgY29ycmVjdC4gU2hvdWxkIHdlIGhhdmUgYSBjYXN0IGZvciBzbWF0Y2gncyBzYWtlPwpJIHdv
dWxkIGhhdmUgdGhvdWdodCB0aGVyZSB3b3VsZCBiZSBhIGxvdCBvZiB0aGVzZSBwYXR0ZXJucyBp
biB0aGUga2VybmVsLgoKSWYgd2UgdW5jb25kaXRpb25hbGx5IHNldCBkZWNyeXB0ZWQgPSBmYWxz
ZSBoZXJlLCBJIHRoaW5rIHdlIHdvdWxkIGJlIG9rIGFzCndlbGwuIFRoYXQgd291bGQgbWF0Y2gg
dGhlIG90aGVyIHNpbWlsYXIgY2FzZXMgYmV0dGVyLgo=

