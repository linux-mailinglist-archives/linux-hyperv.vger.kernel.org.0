Return-Path: <linux-hyperv+bounces-1653-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD93186EA90
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 21:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AF721C21CF7
	for <lists+linux-hyperv@lfdr.de>; Fri,  1 Mar 2024 20:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20CC53393;
	Fri,  1 Mar 2024 20:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoDXRZWB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4655853375;
	Fri,  1 Mar 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326038; cv=fail; b=FWf3C0QcziLC07fm9F5OcVx4hGKtkSzaXQw99W6KmeqEy83htp8hHde1pZ+WXi5WVqwyeTTmp/ZRd9MbKL96BKo07ajTaMfAH1AGe2aio1hYu0peLnGXBfCs+G+uCc0rah8+JGw4WgnEhBj2/9rlnBPGf+U4YWkM2JedphM2hX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326038; c=relaxed/simple;
	bh=pS6ddCjvIz1P/Ec90bi5MzpepMuYGnxVgE3J6LzfIGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pzSDHVIHOxQ8aO0BQoEZf1l6mcHSe8wL+BwvMJd5XbNJeS3jsF02YIBkplCYhLpZ+OKtPjieafyJypRreW3UUU0piRQNDtbKVp5U4sL7prfaMByCBRDht2q9zx0lfukLu+uexD2SSGQ+A5Hsa285qR3ppYmoG6jvG94UMqtqbl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoDXRZWB; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709326037; x=1740862037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pS6ddCjvIz1P/Ec90bi5MzpepMuYGnxVgE3J6LzfIGE=;
  b=OoDXRZWBrjqI+rEKSUzUAaDZbXW0emKimAkvy6Tnnj3Ud1RRe9uIgJNw
   rHy8SN3LjXFnJjw6Pcehdulft8IE2P7XMBHHO+Eka95Kv0zKYv9oVxFwZ
   FAcVCrz1yhz8kel9y2LiZdKoIb2w4y4FARV0HFPDPctFl7UpjVViA6Flx
   YTutP7gpEkE47EcI2PLzv7bBWesypdq3BzZNiDJRDiA7/hZkKim62XZTz
   baynqGS+e6lWnxVfjhgoBVBGzz5o1CH9Il+7hQkp66JEDhbuXvGJUw9FC
   BQCI5z1/9oRW3f6ZzE9fg7dkNnQC38546xqZHavLXOJuqtSnvtJbxSTeq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="14587047"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="14587047"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 12:47:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8244251"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 12:47:17 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 12:47:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 12:47:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 12:47:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 12:47:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bx4M3/0BF0eZm53ZZPwmK+GL82iF2KNuFm2HGyKln/UYE54G9Yutqw/RVos6pOOwkr6E3kvKP4XAWJMmtiBb8qCvD7+rWiqroSgCglveudaZhTQkGpJxLauKlVY/pwlFvBa1w0fAQTTKhF+Vxvry8HDDeSVjUGpyQXwLh2epp1ykcky1R0TrRaaVpyidDX3PzZKiAR6t5ddrESIhAqVz0/HkvMEca117RdH+SowrMmWtIDe9ox0mkHclSTX6Tlm8NTzi1ePdU5pBgxRMqqmKxT5xPVBKiBI/SB/3ryscaMcPmBsQPccNEzyD837uqPGp5L3VkzAW3i5w1rAw5PH2jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pS6ddCjvIz1P/Ec90bi5MzpepMuYGnxVgE3J6LzfIGE=;
 b=oQUiihWqN9eLVB9/dT5WchG2/1CUumOUJSKVIlJLkImr92Ygq8dnFHyRu+DUNwMxvvgy+M2r0v6NDeDfRiwH1XcilSfFB/Xod62A5F3MyrRJnbSQV9urir90ARQVWHp3IkJQw9dEVpF1HNDYd1+pTxCl/y4Z6R2gT+0i/tjsqj0myLdDyBc2042KJeHp5TPfGj5Gbk+CTN8ZQOiJrri/StM8SnPz15ZsHurCbM5vlvWjdjEz8U8JL+/zRJyrKlpmDTiwNhgg/EAWFtfLqlSA3aoHiUvzy1f3xuEFYFf/+FAiw8/Vq6WS45P7YK6VaIs46NK28whimJfAZ4XARLmFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.21; Fri, 1 Mar
 2024 20:47:13 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7339.022; Fri, 1 Mar 2024
 20:47:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"mhklinux@outlook.com" <mhklinux@outlook.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"Cui, Dexuan" <decui@microsoft.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>
Subject: Re: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Topic: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted()
 fails
Thread-Index: AQHaZTRaOJgLUchwQE6XetZW57kOZrEjSxYAgAADkICAABMagIAABxwA
Date: Fri, 1 Mar 2024 20:47:12 +0000
Message-ID: <17356164ffbded9f85d152e6e96f1c2918db98a9.camel@intel.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
	 <20240222021006.2279329-2-rick.p.edgecombe@intel.com>
	 <SN6PR02MB4157B2E6EC690B11AB334522D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <78da25c9160612bc60bb1b421a0226e4368db51a.camel@intel.com>
	 <SN6PR02MB415731A89ACAB7479B059D73D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415731A89ACAB7479B059D73D45E2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|PH7PR11MB7720:EE_
x-ms-office365-filtering-correlation-id: 94a9a761-53aa-4417-7fd2-08dc3a30c5b5
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yRAcKKNSnPDiTHhhEPCyDqMSt2ITaz15POFEmvxi/RTUV2i2+ZVkuGCMz0HGTlbJ1Obke2GTy+dWdekBgN+vufO+VMeD8utwnpNpNvLnH1YzaKRaUbdu2PRy/NWUnAq2dC6Vjbl8f/kal9hiXEKHy6qA4/3m7gMglxp2abur5Q/ofRIfuYRL3b1PFKRdb0O7YOz3GnJi7EGVuqhJp3BqPk7aW2wpjjRMBev6uIpDgUlIxfpfjELtMTgTTbwBpNEsFRewLA3izKXYwNpy8oPhwG1kLog7sX5KqwNmWA5WNHUvmMg5dU4Y3pE6a74mTEwl5okm7sKr60Dk+pVNhq7Yn6I7JnQ7Y7zLuZsrCfehnE9K+rSYORuA5dZIHiOBqtkWpnCtO1qNqRhgPO3yo6ZXKWbfkou9WdDZP8bpk86loxpRtEse+F227EceBwa/fzl67GP28+mpgDsX39nFB3xPpZ2Tpv967oAu2Kzka5gIPNK1PWOGAYuoWtfwdtGsuUHpuODDBZsQu4EC9+mZMCEjD5MJqe1rPcSVTeaGWkoAtP65IICuJGjqQYGJEkUfp87SR7ffD930bKFw9hvdRyGYG6zKSzz/G+yIK19xxrM1LL/PkDSEFMUqhqmbq+Bf+h3COUSguNzO+QCDv1H/pLE5oL2hR7qllyxtU5M7qzkGS1/yVas3wYkhgS29jSPI4jjuq6D0/P0JFtcBHw++S5MHIQaT3Z5MgHgSEHMDwcQWDNw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUZVRUdvdUxqZDNHUHArZ1NJVjgwTkt6d1hGQWM4UkU3QUc0RG4vRTVDT2Nx?=
 =?utf-8?B?T21TWDV6NHFPTUNrWG9YQ3FtY0I2My90N25GdXZZakd4aDFnN1N0ZVFWUlp3?=
 =?utf-8?B?VGRLUktsU0Z6V0hVamN6dldNYzJkaTVnTFJxeElZNVRmVlJWK0hmallmc3ds?=
 =?utf-8?B?cnVDQmIreDZVVmE3WTlYSkpYNlR2VElmTHJ1VWYwVGUzd0s5VFNYM0U2aCti?=
 =?utf-8?B?ZjU4MVBuZ05JdXBWOXRwWFhxU2J2WWtRZWdIRk5iemMzRU5OaXZqa3VBVk1J?=
 =?utf-8?B?THBZZVU4ckhaTGxMdW9NQlMwMXFKZXg5K3ViR04va1Rrbi9peEJ2bytqVmI2?=
 =?utf-8?B?ZDl2VHVXamtkSjdPS1dLYWNSU2FvVE9lQm9BUGtBZ05yNEtDZVpzL0R0RFA2?=
 =?utf-8?B?L0crUVhsNkNyNVExV1lmUTJwZC9KVGpqUXpOTFRoVkpsWi93M0NGaUdhYnJH?=
 =?utf-8?B?U3NiTDBYRlVFYmtTU1ZLYktxQTZJc21YVjU4V05heEx6Z1VuSGtOcWFzcEtH?=
 =?utf-8?B?eXlYQWtYRXhRZUx4VFhiaC93bS9VcmJzaGZaV2FpdHJXY3dNY2QvYnFsN2RE?=
 =?utf-8?B?S0dncXF1ZTlydVJNUUtnM0UzYVo4ZDhjcnRGazZUZlZmSzNhK0pYeElCTlBt?=
 =?utf-8?B?VWwyS0JnM3F0QlhFMUpkcUxmUmdDeldvSU80WHpNei9rSkRJQkhFUCtTQ09H?=
 =?utf-8?B?dkw2WThjZUZ5M1E3RE9iclVVdTFXbmFMNkMrSFdXQlR6Z0lJWkx6emUzV202?=
 =?utf-8?B?V01qVVUzRDhPM2tMTlVWeW9yTi80TGJIWlJyVnRkclBSZnp0UldHcEFuanFw?=
 =?utf-8?B?c1FlcUt6K0NaWWQ1bWpHZFNScm5GZ0NGYTMvYVc2dml4eXdlZlQxdTlIMWhp?=
 =?utf-8?B?VldlQVVEdjZjaHd2dXUvNGFvenZ0am03R2wvOGZMdm5KeUh0N0MvK2hzYTZx?=
 =?utf-8?B?ZG1LQlJKT1N3bEJCcW9hWEF2bE5vSUROZ0theTNwbzlscjlobkRMdGVENHdP?=
 =?utf-8?B?VCtSdmsreTBScWxZR0p4b0V6Y0FaeW1ZNTNxS0hyblo2YUhaVDl1OW45R01o?=
 =?utf-8?B?VlZjeFNybW8vS1l5bXpOblpPT2VOWFhVQTMrZkNIMUpoZGpIMmVBaFVBVmRB?=
 =?utf-8?B?aFRWR1kzRTU4ZnJ6UEFyQzEzL1ZNSUxBOVBJYkZmeXB5NWN3MGV6eFFDYm1K?=
 =?utf-8?B?WThXQmRJVGU0TFY1d0ovN0N0OGtQTDRIN3JNMUhZaHJYaHE2ejZyNXZjbG1L?=
 =?utf-8?B?OTkwTTRUVGZ6clNaRGtKN0UwTEExTXFYcjV2Sk5PM2JUZXlNTjBLa1l4TThp?=
 =?utf-8?B?NW40TUZMU0JGUWpZWDRnUkd4UVpuUThDTFpJVi92cVBLNzBlTWx2akhNeTdl?=
 =?utf-8?B?Ymd5ZGpCdmROalExbXVTc3plbHFNSnZyWDRVU2Y0ajM4UURIUWkwUHBpWVZL?=
 =?utf-8?B?UmI3OUhXSTZWbGhCVHhQUk5WNkRza3FuVHN0am9zUnZKRGFZRGV2YkFoOTh5?=
 =?utf-8?B?UlJOY091cWVBdDRpU0pwMFl3eHpUTEYreDE0YWtYZ0ExbjlYWmIrT2ZsNGtl?=
 =?utf-8?B?ZldDNTFjRCtENkw1RnZQOHlmdjdFMU96cHlHTEFZd1gxWTlMRlZOUDREWGpF?=
 =?utf-8?B?MHg0VW5PdWZxaytGYmdwS0llNEJRUWdzTTJzNW5iTmxTNDZra2haRkNYMjBo?=
 =?utf-8?B?TFI1aGMrNllFc0Q5UXRXNkluTHpGTzFvcFRJNENXcU1RTyt1dWd5cmF4QUhr?=
 =?utf-8?B?NVNoazI5TUQwaDNCNDRPWm1wRVRKME9Qd0VYWWQyQ1R4VUhzc0VUdXA5clhn?=
 =?utf-8?B?R1d1Zk9waG50SDV1cHNxMmRuMSsxVmJXZVhKTVhhSElIMnF6WDVqSFdoOXo3?=
 =?utf-8?B?d3YyNDZiYW15NUZwM25QMnBDbnhJNWtwa1JFRHgvVnFoSGluTTc0SXhkd2JR?=
 =?utf-8?B?ZWlnekgyUSttRUwvdWNQQ2RNcys1aHNaWlh0ekxLRmNkTlpwclJvL09mQ2tw?=
 =?utf-8?B?UFA1a0J1cmcvT29QUEtYSEV5dk5PeW1JeU5OMEFxdUdDT1JQZ3M4Nit2eVNO?=
 =?utf-8?B?UldJRjZFMUJCZ2JOb0RJNVlEV1lWbnQ2OGtGMXcxYmMyNHcyZkhtSm9lQjQv?=
 =?utf-8?B?bitzTHlqUWNLQTNhTHgzOUw4WjIvZmtOTDFVaGdBdHBmeG1HT3NoYlFJbTJj?=
 =?utf-8?B?NUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C3BFB81CD3D2A4899DC0F84CEE9E821@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a9a761-53aa-4417-7fd2-08dc3a30c5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 20:47:12.9127
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hgn12WKZ2QrxC6Nt6mAOo4t5nSB2thiT6V8HX2qIy/ScsSFEkTsG8LysLpPL+KGUC8YPUzlpfceOoP9rJOa1rZpANP/3NDnmzhcoZGHt+ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTAxIGF0IDIwOjIxICswMDAwLCBNaWNoYWVsIEtlbGxleSB3cm90ZToN
Cj4gDQo+IFRoZSBIeXBlci1WIGNhc2UgY2FuIGFjdHVhbGx5IGJlIGEgdGhpcmQgcGF0aCB3aGVu
IGEgcGFyYXZpc29yDQo+IGlzIGJlaW5nIHVzZWQuwqAgSW4gdGhhdCBjYXNlLCBmb3IgYm90aCBU
RFggYW5kIFNFVi1TTlAsIHRoZQ0KPiBoeXBlcnZpc29yIGNhbGxiYWNrcyBpbiBfX3NldF9tZW1v
cnlfZW5jX3BndGFibGUoKSBnbw0KPiB0byBIeXBlci1WIHNwZWNpZmljIGZ1bmN0aW9ucyB0aGF0
IHRhbGsgdG8gdGhlIHBhcmF2aXNvci4gVGhvc2UNCj4gY2FsbGJhY2tzIG5ldmVyIHBhbmljLiBB
ZnRlciBhIGZhaWx1cmUsIGVpdGhlciBhdCB0aGUgcGFyYXZpc29yDQo+IGxldmVsIG9yIGluIHRo
ZSBwYXJhdmlzb3IgdGFsa2luZyB0byB0aGUgaHlwZXJ2aXNvci9WTU0sIHRoZQ0KPiBkZWNyeXB0
ZWQvZW5jcnlwdGVkIHN0YXRlIG9mIHRoZSBtZW1vcnkgaXNuJ3Qga25vd24uwqAgU28NCj4gbGVh
a2luZyB0aGUgbWVtb3J5IGlzIHN0aWxsIHRoZSByaWdodCB0aGluZyB0byBkbywgYW5kIHlvdXIN
Cj4gcGF0Y2ggc2V0IGlzIGdvb2QuIEJ1dCBpbiB0aGUgSHlwZXItViB3aXRoIHBhcmF2aXNvciBj
YXNlLA0KPiB0aGUgbGVha2luZyBpcyBhcHBsaWNhYmxlIG1vcmUgYnJvYWRseSB0aGFuIGp1c3Qg
VERYLg0KPiANCj4gVGhlIHRleHQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIGlzbid0IHNvbWV0aGlu
ZyB0aGF0IEknbGwNCj4gZ28gdG8gdGhlIG1hdCBvdmVyLsKgIEJ1dCBJIHdhbnRlZCB0byBvZmZl
ciB0aGUgc2xpZ2h0bHkgYnJvYWRlcg0KPiBwZXJzcGVjdGl2ZS4NCg0KT2gsIGludGVyZXN0aW5n
LiBJIHRoaW5rIEkgbWlzc2VkIGl0IGJlY2F1c2UgaXQgb25seSBoYXMgYSBzcGVjaWFsDQplbmNf
c3RhdHVzX2NoYW5nZV9maW5pc2goKS4gQnV0IHllYS4gSXQgZG9lcyBzb3VuZCBsaWtlIHRoZSB0
ZXh0IHlvdQ0Kc3VnZ2VzdGVkIGlzIG1vcmUgYWNjdXJhdGUuIEknbGwgdXBkYXRlIGl0Lg0K

