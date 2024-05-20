Return-Path: <linux-hyperv+bounces-2199-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D0D8C9CBF
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 13:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B3D1F219D7
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 May 2024 11:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF6A53384;
	Mon, 20 May 2024 11:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8B764VZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C922952F92;
	Mon, 20 May 2024 11:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206179; cv=fail; b=P3i7qhqerRk49M+dPN7eFutpO3eSm+XKzvWT+nhnqYNpSdLjkOlcHa7/cHJqFjkBUSMxj2Ay+7jXUR4GLesklYi8bP4Ta9dH6sBDGLYuoSE42Q7AyAE3IXT9UyKgwuhTBhQfMDKmBtdR/9qlpsogdkSwXSQZBBHs797uRDcI7bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206179; c=relaxed/simple;
	bh=GLwe2AlXnf/ycpAxr1O3kbKFILqTtgylgh6qUy3ZY/w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9QhYEuAvk46bZ/gbsVjRnQVc7J2ha1qmjd6xhxA4U4ZgLsxn+AbIwCOzIhmNM0Q4zRsPWPKIlGaAvQaGygsNVtqIt9lg6y1aIGUcLtwLtjOAhVtRKiBN5w1ame6SS86462YQEBkVa1cC4uNeHaVyx79cZAaNVIrtrpLzBWkhls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8B764VZ; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716206178; x=1747742178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GLwe2AlXnf/ycpAxr1O3kbKFILqTtgylgh6qUy3ZY/w=;
  b=Q8B764VZjB/P7ErxYAJ55zaoMEgPfOAb9ysEvFqReZFBU1i8yJNIyb1m
   d4VlO4qJUJ6DHvNv3/D5+cNEhCgbK//ol2Kh1GIoGRnS5CWa6+OKho8TZ
   4MgUdZo9BzBwwNvje46jpnlPcD4eYQ6aqxSzz70l6sGJob3QnBmvDFebk
   kMIedoZVv8H1uGW5rRmtI5k/2UW4A4ebl3juvpntVP8UieJVIwM7pi9Ko
   sRwk+i2NzPLsYIe4c6H6gJ7XLjV5qmqkTNOwD2jXwKOaq/kWlez2/uXwd
   Q0Zsf2PXQy6y4+9TUXwAy7xRnO3y+tfIhNMcmrPJ8oHsWrADHxxyg5HKC
   A==;
X-CSE-ConnectionGUID: ktikRiHSSA6hLTp3nFEELQ==
X-CSE-MsgGUID: L5JQPHWwQUqFpgBwi/KXaA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="34843574"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="34843574"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 04:56:17 -0700
X-CSE-ConnectionGUID: xHYmaW1/T9WWNNKMRR2RnA==
X-CSE-MsgGUID: DTD9dLREQVmQa/G1sAXaSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="55743489"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 04:56:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 04:56:16 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 04:56:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 04:56:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQ6OU7ubQ9HEL+x5SoTvWWfHFTrelj0L0I7/qAhEG+C74Mo3P5MUvSLlI6USllCHrj8Xuu6CHYSn1RkSGl71H1chCDaL9P77ZCw96Dt2h0CMBRgoQNsCXIPNu8bxAZQ96lDp3X6bagArTMZY0pnqDdvlZ8wgFMm/MHAe+RPhKl4ZRTi//OfB4IO+6BxNt4ZD4Fqnt9ltUXVBvhboLr6SVqmqDwzkt9Y/FosQeGxiADeWewzMlzIYgfywj+8kannNnHbMS6GJTcYex/XxTH6B435oHgv2f6KIcTPTtqjCjt2PjpnPVEGlpG/EDbeZDbcFRyinSiR3tv1v8onvMWSCOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLwe2AlXnf/ycpAxr1O3kbKFILqTtgylgh6qUy3ZY/w=;
 b=GrCSXXA8i094mhtF0Ew8DUg83spOwckG5xTLPsKgy6Wj24c31i0q3jVEm8BrMipwoCS8+cvfndp0cKYgKqXCQhOsCJ/Pbl4vGgRXSvBfZfyk90GJz9N2Oef7C30SPysn9rEZPTJWyLB5/+MkEBBpzW1SmALVg2vvTAzXpnmhpMAou+l7pgyzC1htQCwxNPyjoGz4IC2iHkX6O/q1w03q6ny5lGNvIn9FqhVcY1UHOPxqWlmN942PxRfdoD04+ipP8YGyqU5iQuXnwNXF4B90dYiJDg4+tWJsP5QA/gGeiMZo7JuFL6VbHuMR98pHtyCqJoWN4qDGZH1hpiJrEepCjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW4PR11MB7077.namprd11.prod.outlook.com (2603:10b6:303:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Mon, 20 May
 2024 11:56:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%4]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 11:56:12 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "kys@microsoft.com" <kys@microsoft.com>, "Cui, Dexuan"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/20] x86/tdx: Rewrite TDCALL wrappers
Thread-Topic: [PATCH 00/20] x86/tdx: Rewrite TDCALL wrappers
Thread-Index: AQHaqGVZpeGzAf2Ws0W10w/EWLQpGbGbiiaAgAR+eAA=
Date: Mon, 20 May 2024 11:56:12 +0000
Message-ID: <05ce6aaae64060dfaa69513e90f35de4a8d114ec.camel@intel.com>
References: <20240517141938.4177174-1-kirill.shutemov@linux.intel.com>
	 <a8628846-1d87-4191-92b8-c7a1e70cb196@intel.com>
In-Reply-To: <a8628846-1d87-4191-92b8-c7a1e70cb196@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW4PR11MB7077:EE_
x-ms-office365-filtering-correlation-id: 19889c83-0ffd-4eb2-ea4b-08dc78c3d8ad
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005|38070700009|921011;
x-microsoft-antispam-message-info: =?utf-8?B?OXp2bDRCK1FTM1BmQlBoOEw2ZG5oUXc0RUU5ZDVBc3hCSjA1aENLS0VkS3VW?=
 =?utf-8?B?aVBvQUl2REJ4WExsZDZaQVRmRjlQNWJoK3pxUWFiUXR4WE1JMFRkeEc5L0RF?=
 =?utf-8?B?Y1QrMGdkNlZtQ2VhM1VLWXpUN3JUbmlwZVF1a2lYQU1ibDlXbDBLZE1uWFhu?=
 =?utf-8?B?SUx2TTAvWjlKbnRGcVh0dm40OEhmVTc4eU5Pbm9RdXpUTnE1eld2WnhXbVdW?=
 =?utf-8?B?SElUWmJ0UGduQXFIQlE2SHZvOEYrRkpzU3Bkc0pWa0oxclc1MGVuTFFCM3Yz?=
 =?utf-8?B?VCttSlhvZTMrRjUwditNaGo4VGFWS21UcjlkZE9aa0pXbW13YnBqdkVmRU1n?=
 =?utf-8?B?VVZGS0ZlUWRlRCtnWUNxR3Q1dEZPeVZLbFdVYlFpUlN6UVdDT2xRQUhvRzBH?=
 =?utf-8?B?U2pFd2RjbEZQcll1TWtCSUZjV3BKckp0THpwT1NNS28xd1hqTHhuejBXdi9Z?=
 =?utf-8?B?bXRaR3JGMmJBUm9mRUhFbVZLcXNvU25YdnlPd3grZWtUQnB5YzJZakUzYjJE?=
 =?utf-8?B?UnpUSkV4UHJ4VVdKUmw5U1lpTDVIclI2bFVzUHNzWjhrdDZ2ZTRmaWVZa2Q1?=
 =?utf-8?B?TVlDcFJ1SFJaWEFPY3FGWW9rQ01VZlRLeVFvK2N3MEpWTFNhSDdhWUJoTENJ?=
 =?utf-8?B?VEFEQ1hSZTBnVkVCNW8wZWhlVmtWdGk0Tm1SNWNxWmJCK1Q3T3kwK1A5Z2Z6?=
 =?utf-8?B?cE9uSDRncGRRQ3g2MVhIbUtRK21LemRvY0U2SXRVckphalNFSmhlNmlKa0lH?=
 =?utf-8?B?VXh0K04xZXJKYWdpSzB0bmZBTkVITklzY0kxNjQwRC80eHJKeXU4ZmhJRVNU?=
 =?utf-8?B?TzIzWWN5cDRIT3lPVFNFR3JIMThiN1FzZWtweDQrQTBQcFNERnFtN29OeUxC?=
 =?utf-8?B?ZElmcnMwOXkyNUFkZ1RwZm5JcE9sKzRTekZKM1ltK2Q5Z2NvQy95bGVtcEVN?=
 =?utf-8?B?RnFIb0ZBMzY4Zmx0UDNWdTJwL3o0ZXFGa21hUEtpMytRaHQ3eTg1L1FKZjNT?=
 =?utf-8?B?b3RyTkF5cGxqYWlQYktNRXhPN0UxVFRUMnlCUFhrb1VNdGwzVFJIbE9Ib2xV?=
 =?utf-8?B?VkkxNWgycXlzU3J0YXdPak1PdDMxYVJWR0hjM1R6U2RuanI1bkdtRkY4OG1j?=
 =?utf-8?B?eEFWWEU4TXB3MTNwaSsxeHNyYkhqaWQzcGhYTnRZQ3Qvem1qbmJmS2h2Q0dB?=
 =?utf-8?B?ZHRaZm5oTzd2QXIvL013b2kyWGNWRlBQUldNeHlmM0VPcXljU2Fabm9TdGVO?=
 =?utf-8?B?MVVJaU9ndXhiRklJNVN2Z0Q3ZGY4blZaQ01Tb3poeFRhUUJRM1dYN0h3OWNK?=
 =?utf-8?B?VmdqTFh1VWI4Y1dydzVMbWdMVnlNb2VFM0puSHUzNXVzNzNDTEUxVlBkdTVw?=
 =?utf-8?B?MVBMVmRsTlcydzNlQ2ZhMjlRQUVCOFM1eThDM2dzUW9YdXF3OGxFQnJMTita?=
 =?utf-8?B?cGtJTTRJZjVmblJ1dHE3TVhQOE80VVJIN3NBNHNqUXFyYmdWZFFpcXBMNWpa?=
 =?utf-8?B?WnBFYWNndmZYMXZjY1NuWDhZdUVXem13aksxWFQ1ZlFQUXB2Z0p5ZzdrSzNR?=
 =?utf-8?B?clFwN1U3VzJnbFRscmIwbm1tM3VDSXY3L3RGZStUaGYySjRmYXA3TGIyYlpm?=
 =?utf-8?B?WTA5WnRQSXlDWEJldlJiaTl2VTljRG1vZlFCb0M2MmlGTzZVaHJSMTZ3ejhZ?=
 =?utf-8?B?SGxBanZ0aUllZ2lrSGd0d2FJUmNiSG02dGFpVGZvWEZIREZyRHQ1ZUlma2xv?=
 =?utf-8?B?dCtobXFYVitRZEdNTG9YaUF6TElGQktwejNpRVFINGlkWlpVMFBwMmtOVklp?=
 =?utf-8?Q?G+dcgWHPp9SbAHPbuhpt+AIT+9lzS9GGCJhbA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGcyU2lIbUpldGZTUkhTanlQM0JkL2NaNGF0VmM5TXZWeG9aSnVnUVhVeU11?=
 =?utf-8?B?a3FkY1VENHFUaVBleEx1TzcwK1g5dzJZYTVwZ1RFL2RQQjZZK01DK2JwUHlq?=
 =?utf-8?B?S3FQS0U2dHdObTViczczdzEzZmE0ZWNTOEc2ZUVwd2ZoQlgzbm9Sdk94cndU?=
 =?utf-8?B?aEgvRXJDeWl3cUpqVW9wMVhUM0Irc0FZU2tEaGRQdnFwZmhscmpicXFVSStI?=
 =?utf-8?B?YzF1S1ByZmZPMHZqR1BCcEQzT0hLeGZqYmtsR2NGT1lsSjhwazNTNnZtNUd6?=
 =?utf-8?B?aGdheGhiNDRpVm1rRVJwZThYaVNLVllibUhNUlFUSE8zQjgzZG5tbS9zVXE5?=
 =?utf-8?B?bjFiWnZ0NkRGVk02WWdUck9SYUdkMmlrc3BhN1RDU1E0WGZQOGJnOFVTSFpt?=
 =?utf-8?B?aXJ0SDZ5VWpldFhBZHZ3czZMcjZmRmtpTTNYenErdHcwajNvWXhTcUxaN3ls?=
 =?utf-8?B?ZFB2dnZiKzN3Vm5BK0RRZURKdnNMZm44SCtwdEJIZS9xRDB0Z0kzZWR1K0RQ?=
 =?utf-8?B?Z1N6bmhnNVk0dDduS09iVFBXbmhvbGdtazZ2Y3RVbENIcU1nZjVvc1d3ODhB?=
 =?utf-8?B?Y1g2VFYwdkwvSEM4SEJxMzNLWnorYnRqS0QxZWNOV0ZnRG9GMzRxT0I1VEZy?=
 =?utf-8?B?OUY2STJlbzJFdENRWlNGaTh3bUU5K3NKSWNQL0xpbWp6T25PeFgwbFhTM3lR?=
 =?utf-8?B?SmUzU3QweXNlbkNMcUtDZzk0MFJIK1VENm50UjhRM3hCSWU0ZUlETlVqaFNz?=
 =?utf-8?B?WThXckQ5WlMrbFIrUktaeW5vMy8zNUsyaE5WMy9KUHNBdkdMdUhhQlVXVGox?=
 =?utf-8?B?TVN5a0VQVlA4Z2N5SS9rNkJ0MTJFZVIrQ0dQQkpNNGcwL1ZmWHpnTXQ3RFov?=
 =?utf-8?B?WWdTcHV2dDBZSlBhcW1qMW9MeUZCaW5naHc1SGFDS1hkSDJEOG8vR2NzYjMx?=
 =?utf-8?B?c0R5Kys5LzNHWGdkem9maytYdVVhSlBUTEs4UlJzTVhQTFpVQzRZY3dTNVFU?=
 =?utf-8?B?aHFUcUh2NnRVRWZydmlkK004RnhSNHJkTTFNQ1BoakcrWWtOZG5OYjBuQW02?=
 =?utf-8?B?NmhhbnpscXJmZTQxbXRRR0V0UTJnUFBreHhqaU1mUFkwVHg2bHoxQzZOZUZp?=
 =?utf-8?B?d2luNDFFSU00UWRTVDd3NFRsaFBmMHA4eVJUSGlreVFRMzNUL09jeUpHa21W?=
 =?utf-8?B?S2hlWHNNNVl5SXZwZ0pJblVEZXlra0phMEwyYnMzcHFwa2ZsaUN6Ujh0YVlT?=
 =?utf-8?B?bVRuQWpLcVJwTmVhVnBrWElObjl5S3JiR0NXL1krT3B1R05URC9uZGZ2aUcz?=
 =?utf-8?B?b1hhS20wSHZ4YzNtQzBlR0IycXM2dER0aVMrbzNGYmJ0R2dsZStUaTIrTTJC?=
 =?utf-8?B?Y3JJZ29FQVFLWkZZb3lvL1RUMGxjd1JBMjRKa0FLNFZDanZEYklkTzc3elhr?=
 =?utf-8?B?eHlUamt0TkxBUkRXWWI3ZFJXY2JSODJwR2NGTmw4Wm55Wk90blVBdkhtaVFa?=
 =?utf-8?B?cGMwdTdKUjBKd2lLVG5TMC93OFNaUWtrU1BKTDdmSGxMVlJnc0liU2J2S1JT?=
 =?utf-8?B?V1M4Y2tYOXRydGJqamVISzlrbXF6cGpUekxkb20yTW4xbnhoVW41VjdZQ2FG?=
 =?utf-8?B?bkFCK2lZZ00vaWtLS3J2dXMvNUQyNkFpVEZSTWQ2Y01ZbTlJb3BtMENtK3pj?=
 =?utf-8?B?MHpVakljQ3U5QlVPODlyMmdURU9NUlNLZWtMUEkvL296UHNjMExoNUtZRHQz?=
 =?utf-8?B?VUZjVFBpSEhKRGZRSnVsaDJ1UC9iUkZhSWh5cU1Hd084M3RhMjYzd1l2SmpL?=
 =?utf-8?B?R2pMbkNpdS9RdWZiMVF3L3B4eUo3OXN5bDBMSFhscFZqRHVvYTEwRVFXSit4?=
 =?utf-8?B?TTVVT3k3VmdUb2Y3bUtDRDMwRzAvUEc2cTBrZk9OZnVNWWxJbnd3dUt4ZFU4?=
 =?utf-8?B?VUZCNWFXRVlhdHlFRnU5Q0hwaEU5NVhDZnJZaXgrVjUrTDdKeGc3WXF3cUdi?=
 =?utf-8?B?K2lzdE43VDVjdmxXUlRMYWZ4SE5XOFcvdDVwOVJQc3VuNlpaZEh1MW5hZ1E4?=
 =?utf-8?B?YzhsN3FoVFZKbTRTcEtPbjg2NG5YKzhKWkxvOFVzVWJNdHNLZnV0YVZTcVhE?=
 =?utf-8?Q?ulJ0sV3yM+/5/Kz/ugs+yDzY7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1BE6BED76DC6442B840E39374ED3DF0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19889c83-0ffd-4eb2-ea4b-08dc78c3d8ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 11:56:12.8576
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9Equ905uO+NEkx4nMGCOv1Nmr3JatfTqs4g1/5ct9HZ1f+nubApckDW90obld6fiWuD+kq1QSkHQ/A2pFtC/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7077
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTA1LTE3IGF0IDA4OjE4IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
T24gNS8xNy8yNCAwNzoxOSwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3RlOg0KPiA+ICBhcmNoL3g4
Ni9ib290L2NvbXByZXNzZWQvdGR4LmMgICAgfCAgMzIgKy0tLQ0KPiA+ICBhcmNoL3g4Ni9jb2Nv
L3RkeC90ZGNhbGwuUyAgICAgICAgfCAxNDUgKysrKysrKysrKy0tLS0tDQo+ID4gIGFyY2gveDg2
L2NvY28vdGR4L3RkeC1zaGFyZWQuYyAgICB8ICAyNiArLS0NCj4gPiAgYXJjaC94ODYvY29jby90
ZHgvdGR4LmMgICAgICAgICAgIHwgMjk4ICsrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+ICBhcmNoL3g4Ni9oeXBlcnYvaXZtLmMgICAgICAgICAgICAgfCAgMzMgKy0tLQ0KPiA+ICBh
cmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmggfCAxNTkgKysrKysrKysrKystLS0tLQ0K
PiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS90ZHguaCAgICAgICAgfCAgIDIgKw0KPiA+ICBhcmNo
L3g4Ni92aXJ0L3ZteC90ZHgvdGR4Y2FsbC5TICAgfCAgMjkgKy0tDQo+ID4gIHRvb2xzL29ianRv
b2wvbm9yZXR1cm5zLmggICAgICAgICB8ICAgMiArLQ0KPiA+ICA5IGZpbGVzIGNoYW5nZWQsIDMy
MiBpbnNlcnRpb25zKCspLCA0MDQgZGVsZXRpb25zKC0pDQo+IA0KPiBJIHdhcyBnb2luZyB0byBn
cnVtYmxlIGFib3V0IHRoaXMgYmVpbmcgYSB3YXN0ZSBvZiB0aW1lLCBidXQgaXQgbG9va3MNCj4g
bGlrZSB0aGlzIGdpdmVzIHNtYWxsZXIgYmluYXJpZXMgYW5kIGxlc3MgY29kZS4gIExvb2tzIHBy
b21pc2luZyBzbyBmYXIhDQo+IA0KDQpJJ2xsIHN0YXJ0IHRvIHdvcmsgb24gdGhlIFNFQU1DQUxM
IHBhcnQgdG9vLiAgVGhhbmtzIEtpcmlsbCBmb3IgdGhlIHdvcmsuDQo=

