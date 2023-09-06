Return-Path: <linux-hyperv+bounces-7-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 999967933EB
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Sep 2023 05:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11721C2090E
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Sep 2023 03:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D509658;
	Wed,  6 Sep 2023 03:06:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1C7E
	for <linux-hyperv@vger.kernel.org>; Wed,  6 Sep 2023 03:06:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2309CD2;
	Tue,  5 Sep 2023 20:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693969594; x=1725505594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=r7R3v6SArfGC7zPfipX/Plkv/8KKnopx/RSbmmMtV6U=;
  b=QEDnPbMr+UGTHAx2NfAWfyRkbn7c/Eo7EPBKmcSdd/as7IlIf0IlXLt8
   4ZmC8hejYyz1Q8+ELU6NC/48rVHGNGaQe1pKX/bUqskbMDMJB7ECKltS+
   fj0+sETUNMfyynFCR/oOY5EziUz0zn6f+Aj2l34rib/GeCtt4jl9UECzk
   w6LtXGz5X0rj5cBngAb9XfSS3rzhCGza1taB7bBbiRFKMri6ZJ4xpRGaI
   FHPjtfOa3fydzZTsCNFCDPnOiFZCz7UcQCHvmIjY6tHRA55QvrLhE7tTJ
   cEyNt0bB81razJg+VbrfrQ4wMVn2MuGayBVV4/Rd0pxqOiT4T6xB65rcM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="376873726"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="376873726"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 20:06:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="856239743"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="856239743"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 20:06:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 20:06:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 20:06:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 20:06:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 20:06:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3CvX7beMIokueK1nPsH+zWtjUA9fHddO0wG9LA9R7O0hAemU8og3m6jX2m3Ezkiqu6bSjfPNLglmkuHBVDMhxYBPgjMm1cWV9sQyrcjiAqfy+ecxvt/MIhq+hoDupmfVhjl0yXLoPnCLQ9QS9l9hDTGAzU6WmwS+G4BPghJdNFyry1pHaP18lU6boSjoITF65LspNMIidDkfnD7T4Uh1ZMt8IG/vSQkXLBRd9tsZlW2bwGfhqnsKx7QaIDbF4i+xADOIf+aimBJbnbQagO5Sri2HpUK7ZdApMOdAEkIoXiYIFouFxay76qrTpTwOc3yQh4pM2OvxLfD1lw08MyIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7R3v6SArfGC7zPfipX/Plkv/8KKnopx/RSbmmMtV6U=;
 b=LjlurILDLRkGptEXx6FmJeRXPA3ia8jLyQ4wuAoYipApLTzhrtoeWU0RL34s1qhJllH6ogg/LONdqDPdOy7lDrsoDs+kaY45aNwNCOnL7zgcvbrruhgUbsAjobyyPpUh5PXgZi2QtBz7RKDuopHyopuDuus+Ar/S7HTOOuwZCsn3T5A1IqmtG5l+kxMT9cUW2Hectjh+aXxC6Cy8v8usOb/KluXVZP4WSugU8Cq1clBLeTA9TvfV/OcmHzwEBF9kXTqFXIgSUkhQ5q5HJqr2JhwukH6XtCZw+e9EOLcXjBNBCA2iyrcrhEA8QccJY/A44ddCS5ZmKKEGkYD8xF/mag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 03:06:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 03:06:27 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "x86@kernel.org" <x86@kernel.org>, "Lutomirski, Andy" <luto@kernel.org>,
	"Hansen, Dave" <dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Cui, Dexuan"
	<decui@microsoft.com>, "mikelley@microsoft.com" <mikelley@microsoft.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "nik.borisov@suse.com"
	<nik.borisov@suse.com>, "chu, jane" <jane.chu@oracle.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Luck, Tony" <tony.luck@intel.com>, "Christopherson,, Sean"
	<seanjc@google.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "brijesh.singh@amd.com"
	<brijesh.singh@amd.com>, "Jason@zx2c4.com" <Jason@zx2c4.com>, "Williams, Dan
 J" <dan.j.williams@intel.com>
CC: "mheslin@redhat.com" <mheslin@redhat.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andavis@redhat.com" <andavis@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v10 1/2] x86/tdx: Retry partially-completed page
 conversion hypercalls
Thread-Topic: [PATCH v10 1/2] x86/tdx: Retry partially-completed page
 conversion hypercalls
Thread-Index: AQHZzJ3AAFJQ5AOcC026wSOVTlBOabANJzWAgAAdzAA=
Date: Wed, 6 Sep 2023 03:06:26 +0000
Message-ID: <2a7c27a206244d46d1d7da6f60ccd0cb498beab0.camel@intel.com>
References: <20230811214826.9609-1-decui@microsoft.com>
	 <20230811214826.9609-2-decui@microsoft.com>
	 <cb3de236547eefd48f5ea098dfa72a45373257ab.camel@intel.com>
In-Reply-To: <cb3de236547eefd48f5ea098dfa72a45373257ab.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|PH0PR11MB5127:EE_
x-ms-office365-filtering-correlation-id: b0c4a7c5-2dbf-4ff8-fb8d-08dbae864283
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: onk9rd9E33pua8ke2ggFr9gQyQII9SEnz1KVPJLMcyqwf8aAu3r8xoxuHWOaHJWRco1GiO2HZJINdHdmsIphNOGjNXHbt+v+3mQUUUM4kEu7rWIlgnab+aClP3wb7y5dcmBvm+SXeDhqrMdRZvKSLs+BBGWUIc8XZ1LrBwVSFewVueeand37yFOHFH0nf0+auhL3E7i3im6f4UuheAUMDhgNXIfVpo0RWgLDE5EfOq17GNFYOPxJ8H/x5IsnF2zG6NZ1kAw5tsUnd+xafrMU3iWQZQqjLf+zvZ38pgUddxXgA3yv2diN3aPp6IxyVds6C+1fPF0f7m0V+M/3TY1GmFICLIX9cMQRLWexqaTUqioo/acE+RWHQSTfe0O8uQT7WZs+pIj36YybcfOP+hm+qsiPi7jnyvb4STYzsQqaqBcPCwMaNX/Of5ekjFNuNBgsdqQuIrblwhzknwskezpiqSqJhzeLW1tF2a71i0fBg9O2VtCucqnS8EMWXEKgbRkT2LEVgjYuDNt+p1eOg/Sll/jzDsrs44D4VwTX+PEdPaP3Cv/GjeQVoVqgzITQULGT4cKcm2dcqO6hodTa0eQdm5/b+w6pPkS08T4gz50ILr0Avg6YYEQUb1tM4UaAqDRPyjiWxh+FJZTse0+XtM3oyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(1800799009)(186009)(451199024)(2906002)(66899024)(86362001)(6512007)(2616005)(26005)(478600001)(36756003)(71200400001)(6506007)(6486002)(38070700005)(38100700002)(83380400001)(82960400001)(122000001)(921005)(7416002)(41300700001)(8676002)(8936002)(4326008)(5660300002)(110136005)(91956017)(316002)(6636002)(76116006)(54906003)(64756008)(66556008)(66446008)(66476007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEd0V01YUWtvV21LVmlocTFvODdkR0kwS01XV2ZLd2dhZXJoUDZMbWJhbHI1?=
 =?utf-8?B?WFlwQkI0enFGRHp0NFAxTHZOcEdCb0ZRM09VSyt5L3ltR2gzei82cmlQNWIy?=
 =?utf-8?B?OFE5aStrVjlCYkhJVU9yUE1ESzJSZWhHbXpUUHpPMVdVWkpmKzJ2SDJxaXAz?=
 =?utf-8?B?K0h2RU5wMndzQytHSDFSd284Y1dyMTZ0djhaTzNyaHdJSS8zNFU1SXcweE1n?=
 =?utf-8?B?bUJkcHgxQmcyS1Vtd09PVHRqWmZaN2VrL1dzdDNCSUtEZjkxaWZIRys5b0FR?=
 =?utf-8?B?OU0xQVRaVm9wNGFmRkVwdUNNVjhMRUtZM2dpbVQ4dUZYTWdSK2IyQmNhRXBs?=
 =?utf-8?B?ejhKTXlXZ0pYQng0OWg4MGNhMlJvc0pkc2JjQXZVUnRMcmI0bHBHZTU2YXNt?=
 =?utf-8?B?Y1JOdkovR1pSSVN6Y0JaSytVRzAvTW4vUkZoMUM3d084R25BdWs2bXIycUND?=
 =?utf-8?B?UmJoZld5UWV1WkIxRlhMdk5HZmhITnpiLzJWS1E2ZmUwRnlhSEltaDgyQTVp?=
 =?utf-8?B?SlhYQTVDYTIrRWY5Mk9TMUtxTzlaNlZLRnk3a0J1VlZObWR1VWRQYzZjeFo3?=
 =?utf-8?B?dnJnbmVZSWlyODFiTytGZ2N4MW4ra1lzcC9ucllpVDdrb1FuMzR4OUFodWFt?=
 =?utf-8?B?cGxPSkFKQ2xLd1BQS1RaRTNoY25Ma2xncVFFZ1loNWtKWkp5UGlweExPRjNx?=
 =?utf-8?B?VG16NXZCZlFCVExubGZOS2VyK0JYdm13RzJ1NFBtMGYzNGtxcEVmandZd2sr?=
 =?utf-8?B?RktZSWJodmVhemVmYTJsZllzU2pZZXRrSU9MSjlIWnhiVmhEZHQ5YnkzTVhO?=
 =?utf-8?B?ZWhzSVc2V3NJSHJGd3g2WG91NElaL2Ria2E3SHRVTUJxL0ZyUUFUWVpXWEVD?=
 =?utf-8?B?TjB3ZnZkWVV6TlNIY2ZocDdFeU5aa2tiK1U1MWdGdjZzWndZSTUyQ201RjlP?=
 =?utf-8?B?R0VpSlhmTXc2UFJHZ2FRYjc2Q1lTdXNQMWcvM1d4MHhiRnVJZmsrdTR5ZDRE?=
 =?utf-8?B?M1k2QXBsOWExUFlRcHBSdi8rR1RrMVFFOERCUUxWcGc1VU8ySXFzcVZDUEY5?=
 =?utf-8?B?enJGMmFxMEJNbjdLZnhaOWNDN1c2UExXb25yb1BLLy9WcVhPdFQyVE52a1B4?=
 =?utf-8?B?bW5hWENtTlhERGFoZkxSM0lWRVE1cTdYNHR5WGZ0d25LNUpEc2xFS1dWUjkx?=
 =?utf-8?B?bnU1TEdxN1pFOFFYREExbmQveFNSaitwb3QxUU53YTdOTkZTTHJGYlZiMGg4?=
 =?utf-8?B?Qkc5UnovQUZjZ0R1Z2Z5OEJMR0VWSXlNdGZVdTQyY1k1K3l0ZFZobFdmMzc3?=
 =?utf-8?B?TGRmS290cUFuRTRnbGlvWmJCVHl1V2dlQnFuS01OeTZxT3lPQjR2cnEzdjJr?=
 =?utf-8?B?VFVhd045QlczcW5nSDFJNjNhNjFJYk5NMWhsdXZlVGVBTC9CSER3eW4zekNj?=
 =?utf-8?B?Tm5sVkdpTkpSMU5hdDVsMkc5KzhBNGd4MU9MNXpVamora2s4MWxCazdUMzkw?=
 =?utf-8?B?RC9BbTNISXJCcXpoQnhwTXZNeWhTcTUxZURJa3c1dzhnaU0rTHBVQjBjbW1y?=
 =?utf-8?B?TGs4UHovbTlEclVPdnV2b2xzVi9KRDhWa1BhbXh2N0d4ZzBXTjgrSEI4OHI1?=
 =?utf-8?B?akcwbU5Oa0NnZmpONUNZNXc1ckNZMFlKalA5eHliVHZkeGoxUlljY0h1dlBz?=
 =?utf-8?B?OGt5N2cvQS9XaFpzdDZSZU9zRDRiS0JJMlVFTWc4ZStXSWgvdmdKZEo4NGJP?=
 =?utf-8?B?ekczZjRTb3BlcXYzaVZGQjdnL3hPMGZXR1ZqS3ZIeHpTZ2x0VGNtelQrdnNE?=
 =?utf-8?B?NmpEVC9TSGJaTU1EZTlXWjJXaGs5YTJJNExMOW45YURoWElrUjhva2k2Tmow?=
 =?utf-8?B?SVllSDVMdkp4K3BzWUk3d2tjL3ZET205MUN0ejEyeXNnQUt2MWxZWHBIcVdI?=
 =?utf-8?B?N2pNYlNseXVsMGRRQlA0aHcyK29TbUdqeGlPeExpYnpjYTcvNHhNVzRSRGpX?=
 =?utf-8?B?c3pib2ZzNUJYT29UTTd4eHcxbXNEdUN6TVhySis2QXRiVHRoU0NFSjZINFFF?=
 =?utf-8?B?S2hPN3dBSDNUNWhzNG13ZUJhL3lRVjUyU2pUc1ZzL3FQQ3hPV2FSYW9yV2dL?=
 =?utf-8?Q?4ChOG77s322nzQGHCslrAJJO/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F2EBD16CA3A5DF4F9AF9A73A2B12E92C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c4a7c5-2dbf-4ff8-fb8d-08dbae864283
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 03:06:26.7739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ch+QdhCfIMzcmSbvGWqSXVuT1swGCUO0r9Hwg8QE++cDkf41hs/+JzzMPUKXSC+BRGFk6aXm5vXpHWEBBmLghg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gV2VkLCAyMDIzLTA5LTA2IGF0IDAxOjE5ICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiBP
biBGcmksIDIwMjMtMDgtMTEgYXQgMTQ6NDggLTA3MDAsIERleHVhbiBDdWkgd3JvdGU6DQo+ID4g
VERYIGd1ZXN0IG1lbW9yeSBpcyBwcml2YXRlIGJ5IGRlZmF1bHQgYW5kIHRoZSBWTU0gbWF5IG5v
dCBhY2Nlc3MgaXQuDQo+ID4gSG93ZXZlciwgaW4gY2FzZXMgd2hlcmUgdGhlIGd1ZXN0IG5lZWRz
IHRvIHNoYXJlIGRhdGEgd2l0aCB0aGUgVk1NLA0KPiA+IHRoZSBndWVzdCBhbmQgdGhlIFZNTSBj
YW4gY29vcmRpbmF0ZSB0byBtYWtlIG1lbW9yeSBzaGFyZWQgYmV0d2Vlbg0KPiA+IHRoZW0uDQo+
ID4gDQo+ID4gVGhlIGd1ZXN0IHNpZGUgb2YgdGhpcyBwcm90b2NvbCBpbmNsdWRlcyB0aGUgIk1h
cEdQQSIgaHlwZXJjYWxsLiAgVGhpcw0KPiA+IGNhbGwgdGFrZXMgYSBndWVzdCBwaHlzaWNhbCBh
ZGRyZXNzIHJhbmdlLiAgVGhlIGh5cGVyY2FsbCBzcGVjIChha2EuDQo+ID4gdGhlIEdIQ0kpIHNh
eXMgdGhhdCB0aGUgTWFwR1BBIGNhbGwgaXMgYWxsb3dlZCB0byByZXR1cm4gcGFydGlhbA0KPiA+
IHByb2dyZXNzIGluIG1hcHBpbmcgdGhpcyByYW5nZSBhbmQgaW5kaWNhdGUgdGhhdCBmYWN0IHdp
dGggYSBzcGVjaWFsDQo+ID4gZXJyb3IgY29kZS4gIEEgZ3Vlc3QgdGhhdCBzZWVzIHN1Y2ggcGFy
dGlhbCBwcm9ncmVzcyBpcyBleHBlY3RlZCB0bw0KPiA+IHJldHJ5IHRoZSBvcGVyYXRpb24gZm9y
IHRoZSBwb3J0aW9uIG9mIHRoZSBhZGRyZXNzIHJhbmdlIHRoYXQgd2FzIG5vdA0KPiA+IGNvbXBs
ZXRlZC4NCj4gPiANCj4gPiBIeXBlci1WIGRvZXMgdGhpcyBwYXJ0aWFsIGNvbXBsZXRpb24gZGFu
Y2Ugd2hlbiBzZXRfbWVtb3J5X2RlY3J5cHRlZCgpDQo+ID4gaXMgY2FsbGVkIHRvICJkZWNyeXB0
IiBzd2lvdGxiIGJvdW5jZSBidWZmZXJzIHRoYXQgY2FuIGJlIHVwIHRvIDFHQg0KPiA+IGluIHNp
emUuICBJdCBpcyBldmlkZW50bHkgdGhlIG9ubHkgVk1NIHRoYXQgZG9lcyB0aGlzLCB3aGljaCBp
cyB3aHkNCj4gPiBub2JvZHkgbm90aWNlZCB0aGlzIHVudGlsIG5vdy4NCj4gDQo+IFNvcnJ5IGZv
ciBsYXRlIGNvbW1lbnRpbmcuDQo+IA0KPiBOaXQ6DQo+IA0KPiBJTUhPIHRoaXMgcGF0Y2ggaXMg
ZG9pbmcgdHdvIHNlcGFyYXRlIHRoaW5ncyB0b2dldGhlcjoNCj4gDQo+IDEpIGNvbnZlcnQgdGR4
X2VuY19zdGF0dXNfY2hhbmdlZCgpIHRvIHRkeF9tYXBfZ3BhKCkgdG8gdGFrZSBwaHlzaWNhbCBh
ZGRyZXNzLg0KPiAyKSBIYW5kbGUgTWFwR1BBKCkgcmV0cnkNCj4gDQo+IFRoZSByZWFzb24gb2Yg
ZG9pbmcgMSksIElJVUMsIGlzIGhpZGRlbiBpbiB0aGUgc2Vjb25kIHBhdGNoLCB0aGF0IGh5cGVy
diBndWVzdA0KPiBjb2RlIGlzIHVzaW5nIHZ6YWxsb2MoKS4gIEkuZS4sIGhhbmRsZSBNYXBHUEEo
KSByZXRyeSBkb2Vzbid0IHN0cmljdGx5IHJlcXVpcmUNCj4gdG8gY2hhbmdlIEFQSSB0byB0YWtl
IFBBIHJhdGhlciB0aGFuIFZBLg0KPiANCj4gU28gdG8gbWUgaXQncyBiZXR0ZXIgdG8gc3BsaXQg
dGhpcyBpbnRvIHR3byBwYXRjaGVzIGFuZCBnaXZlIHByb3Blcmx5DQo+IGp1c3RpZmljYXRpb24g
dG8gZWFjaCBvZiB0aGVtLg0KDQpTb3JyeSBJIHJlYWxpemVkIEkgbWlzc2VkIG9uZSBwb2ludCBp
biB0aGUgcmV0cnkgbG9naWMgYmVsb3csIHNvIGZlZWwgZnJlZSB0bw0KaWdub3JlIHRoaXMgY29t
bWVudC4NCg0KPiANCj4gQWxzbywgc2VlIGJlbG93IGZvciB0aGUgcmV0cnkgLi4uDQo+IA0KPiA+
IA0KPiA+IEFja2VkLWJ5OiBLaXJpbGwgQS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51
eC5pbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxleUBt
aWNyb3NvZnQuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBLdXBwdXN3YW15IFNhdGh5YW5hcmF5YW5h
biA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5jb20+DQo+ID4gLS0tDQo+ID4g
IGFyY2gveDg2L2NvY28vdGR4L3RkeC5jICAgICAgICAgICB8IDY0ICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0NCj4gPiAgYXJjaC94ODYvaW5jbHVkZS9hc20vc2hhcmVkL3RkeC5oIHwg
IDIgKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDU0IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9u
cygtKQ0KPiA+IA0KPiA+IENoYW5nZXMgaW4gdjEwOg0KPiA+ICAgICBEYXZlIGtpbmRseSByZS13
cm90ZSB0aGUgY2hhbmdlbG9nLiBObyBvdGhlciBjaGFuZ2VzLg0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9jb2NvL3RkeC90ZHguYyBiL2FyY2gveDg2L2NvY28vdGR4L3RkeC5jDQo+
ID4gaW5kZXggMWQ2Yjg2M2M0MmIwMC4uNzQ2MDc1ZDIwY2QyZCAxMDA2NDQNCj4gPiAtLS0gYS9h
cmNoL3g4Ni9jb2NvL3RkeC90ZHguYw0KPiA+ICsrKyBiL2FyY2gveDg2L2NvY28vdGR4L3RkeC5j
DQo+ID4gQEAgLTcwMywxNCArNzAzLDE1IEBAIHN0YXRpYyBib29sIHRkeF9jYWNoZV9mbHVzaF9y
ZXF1aXJlZCh2b2lkKQ0KPiA+ICB9DQo+ID4gIA0KPiA+ICAvKg0KPiA+IC0gKiBJbmZvcm0gdGhl
IFZNTSBvZiB0aGUgZ3Vlc3QncyBpbnRlbnQgZm9yIHRoaXMgcGh5c2ljYWwgcGFnZTogc2hhcmVk
IHdpdGgNCj4gPiAtICogdGhlIFZNTSBvciBwcml2YXRlIHRvIHRoZSBndWVzdC4gIFRoZSBWTU0g
aXMgZXhwZWN0ZWQgdG8gY2hhbmdlIGl0cyBtYXBwaW5nDQo+ID4gLSAqIG9mIHRoZSBwYWdlIGlu
IHJlc3BvbnNlLg0KPiA+ICsgKiBOb3RpZnkgdGhlIFZNTSBhYm91dCBwYWdlIG1hcHBpbmcgY29u
dmVyc2lvbi4gTW9yZSBpbmZvIGFib3V0IEFCSQ0KPiA+ICsgKiBjYW4gYmUgZm91bmQgaW4gVERY
IEd1ZXN0LUhvc3QtQ29tbXVuaWNhdGlvbiBJbnRlcmZhY2UgKEdIQ0kpLA0KPiA+ICsgKiBzZWN0
aW9uICJUREcuVlAuVk1DQUxMPE1hcEdQQT4iLg0KPiA+ICAgKi8NCj4gPiAtc3RhdGljIGJvb2wg
dGR4X2VuY19zdGF0dXNfY2hhbmdlZCh1bnNpZ25lZCBsb25nIHZhZGRyLCBpbnQgbnVtcGFnZXMs
IGJvb2wgZW5jKQ0KPiA+ICtzdGF0aWMgYm9vbCB0ZHhfbWFwX2dwYShwaHlzX2FkZHJfdCBzdGFy
dCwgcGh5c19hZGRyX3QgZW5kLCBib29sIGVuYykNCj4gPiAgew0KPiA+IC0JcGh5c19hZGRyX3Qg
c3RhcnQgPSBfX3BhKHZhZGRyKTsNCj4gPiAtCXBoeXNfYWRkcl90IGVuZCAgID0gX19wYSh2YWRk
ciArIG51bXBhZ2VzICogUEFHRV9TSVpFKTsNCj4gPiArCS8qIFJldHJ5aW5nIHRoZSBoeXBlcmNh
bGwgYSBzZWNvbmQgdGltZSBzaG91bGQgc3VjY2VlZDsgdXNlIDMganVzdCBpbiBjYXNlICovDQo+
ID4gKwljb25zdCBpbnQgbWF4X3JldHJpZXNfcGVyX3BhZ2UgPSAzOw0KPiA+ICsJaW50IHJldHJ5
X2NvdW50ID0gMDsNCj4gDQo+IC4uLiBJIHRyaWVkIHRvIGRpZyB0aGUgZnVsbCBoaXN0b3J5LCBi
dXQgc29ycnkgaWYgSSBhbSBzdGlsbCBtaXNzaW5nIHNvbWV0aGluZy4NCj4gDQo+IFVzaW5nIDMg
aXMgZmluZSBpZiAiUmV0cnlpbmcgdGhlIGh5cGVyY2FsbCBhIHNlY29uZCB0aW1lIHNob3VsZCBz
dWNjZWVkIiBpcw0KPiBhbHdheXMgdHJ1ZS4gIEkgYXNzdW1lIHRoaXMgaXMgYmVjYXVzZSBoeXBl
clYgaXMgYWJsZSB0byBoYW5kbGUgbGFyZ2UgYW1vdW50IG9mDQo+IHBhZ2VzIGluIG9uZSBjYWxs
Pw0KPiANCj4gVGhhdCBiZWluZyBzYWlkLCB0aGlzIGlzIHB1cmVseSBoeXBlcnZpc29yIGltcGxl
bWVudGF0aW9uIHNwZWNpZmljLiAgSGVyZSBJSVVDDQo+IExpbnV4IGlzIHRyeWluZyB0byBkZWZp
bmUgYSBub24tc3BlYy1iYXNlZCB2YWx1ZSB0byByZXRyeSwgd2hpY2ggY2FuIGhhcHBlbiB0bw0K
PiB3b3JrIGZvciBoeXBlcnYgKmN1cnJlbnQqIGltcGxlbWVudGF0aW9uLiAgSSBhbSBub3Qgc3Vy
ZSB3aGV0aGVyIGl0J3MgYSBnb29kDQo+IGlkZWE/ICBGb3IgaW5zdGFuY2UsIHdoYXQgaGFwcGVu
cyBpZiBoeXBlcnYgaXMgY2hhbmdlZCBpbiB0aGUgZnV0dXJlIHRvIHJlZHVjZQ0KPiB0aGUgbnVt
YmVyIG9mIHBhZ2VzIGl0IGNhbiBoYW5kbGUgaW4gb25lIGNhbGw/DQo+IA0KPiBJcyB0aGVyZSBh
bnkgaHlwZXJ2IHNwZWNpZmljYXRpb24gdG8gZGVmaW5lIGhvdyBtYW55IHBhZ2VzIGl0IGNhbiBo
YW5kbGUgaW4gb25lDQo+IGNhbGw/DQo+IA0KPiBXaGF0J3MgbW9yZSwgZ2l2ZW4gdGhpcyBmdW5j
dGlvbiBvbmx5IHRha2VzIGEgcmFuZG9tIHJhbmdlIG9mIHBhZ2VzLCBpdCBtYWtlcw0KPiBldmVu
IG1vcmUgc3RyYW5nZSB0byB1c2UgaGFyZC1jb2RlZCByZXRyeSBoZXJlLiAgTG9va3MgYSBtb3Jl
IHJlYXNvbmFibGUgd2F5IGlzDQo+IHRvIGxldCB0aGUgY2FsbGVyIHdobyBrbm93cyBob3cgbWFu
eSBwYWdlcyBhcmUgZ29pbmcgdG8gYmUgY29udmVydGVkLCBhbmQNCj4gKmlkZWFsbHkqLCBhbHNv
IGtub3dzIHRoZSB3aGljaCBoeXBlcnZpc29yIGlzIHJ1bm5pbmcgdW5kZXJuZWF0aCwgdG8gZGV0
ZXJtaW5lDQo+IGhvdyBtYW55IHBhZ2VzIHRvIGJlIGNvbnZlcnRlZCBpbiBvbmUgY2FsbC4gIA0K
PiANCj4gRm9yIGluc3RhbmNlLCBhbnkgaHlwZXJ2IHNwZWNpZmljIGd1ZXN0IGNvZGUgY2FuIHNh
ZmVseSBhc3N1bWUgaHlwZXJ2IGlzIGFibGUgdG8NCj4gaGFuZGxlIGhvdyBtYW55IHBhZ2VzIHRo
dXMgY2FuIGRldGVybWluZSBob3cgbWFueSBwYWdlcyB0byB0cnkgaW4gb25lIGNhbGwuDQo+IA0K
PiBKdXN0IG15IDJjZW50cy4gIEFuZCBmZWVsIGZyZWUgdG8gaWdub3JlIGlmIGFsbCBvdGhlcnMg
YXJlIGZpbmUgd2l0aCB0aGUgY3VycmVudA0KPiBzb2x1dGlvbiBpbiB0aGlzIHBhdGNoLg0KPiAN
Cj4gDQoNCkFoLCByZWFkaW5nIHBhdGNoIGFnYWluIEkgbWlzc2VkIHRoZSBmYWN0IHRoYXQgcmV0
cnkgaXMgb25seSBjb25zdW1lZCB3aGVuIG5vDQpmb3J3YXJkIHByb2dyZXNzIGlzIG1hZGUuICAg
SWYgdGhlcmUncyBhbnkgcGFnZSBoYXMgYmVlbiBjb252ZXJ0ZWQgYnkgdGhlDQpoeXBlcnZpc29y
LCByZXRyeV9jb3VudCBpcyByZXNldCB0byAwLCBhbmQgdGhpcyBmdW5jdGlvbiB3aWxsIGxvb3Ag
dW50aWwgYWxsDQpwYWdlcyBhcmUgY29udmVydGVkLiBTbyBmZWVsIGZyZWUgdG8gaWdub3JlIG15
IGFib3ZlIGNvbW1lbnRzLg0KDQpCdXQgaXMgaXQgYmV0dGVyIHRvIGV4cGxpY2l0bHkgY2FsbCB0
aGlzIG91dCBpbiB0aGUgY29tbWVudD8NCg0KLyoNCiAqIFdoZW4gdGhlIGh5cGVyY2FsbCBtYWRl
IG5vIGZvcndhcmQgcHJvZ3Jlc3MsIHJldHJ5aW5nIHRoZSBoeXBlcmNhbGwgYSBzZWNvbmQNCiAq
IHRpbWUgc2hvdWxkIHN1Y2NlZWQgdG8gbWFrZSBzb21lIHByb2dyZXNzLiAgVXNlIDMganVzdCBp
biBjYXNlLg0KICovDQoNCkFsc28sIHRoaXMgInJldHJ5IHcvbyBmb3J3YXJkIHByb2dyZXNzIiBz
ZWVtcyBhIGxpdHRsZSBiaXQgb2RkLCBpLmUuLCBpdCBpcyBhDQpzcGVjaWFsIGNhc2Ugd2hlbiBo
eXBlcnZpc29yIGNhbm5vdCBjb252ZXJ0IGFueS4gIEhhdmUgeW91IHNlZW4gYW55IGluIHByYWN0
aWNlPw0KSG93IHRydWUgY2FuIHdlIHNheSAicmV0cnlpbmcgYSBzZWNvbmQgdGltZSBzaG91bGQg
c3VjY2VlZCI/DQoNCj4gPiArDQo+ID4gKwkJaWYgKHJldCAhPSBURFZNQ0FMTF9TVEFUVVNfUkVU
UlkpDQo+ID4gKwkJCXJldHVybiAhcmV0Ow0KPiA+ICsJCS8qDQo+ID4gKwkJICogVGhlIGd1ZXN0
IG11c3QgcmV0cnkgdGhlIG9wZXJhdGlvbiBmb3IgdGhlIHBhZ2VzIGluIHRoZQ0KPiA+ICsJCSAq
IHJlZ2lvbiBzdGFydGluZyBhdCB0aGUgR1BBIHNwZWNpZmllZCBpbiBSMTEuIFIxMSBjb21lcw0K
PiA+ICsJCSAqIGZyb20gdGhlIHVudHJ1c3RlZCBWTU0uIFNhbml0eSBjaGVjayBpdC4NCj4gPiAr
CQkgKi8NCj4gPiArCQltYXBfZmFpbF9wYWRkciA9IGFyZ3MucjExOw0KPiA+ICsJCWlmIChtYXBf
ZmFpbF9wYWRkciA8IHN0YXJ0IHx8IG1hcF9mYWlsX3BhZGRyID49IGVuZCkNCj4gPiArCQkJcmV0
dXJuIGZhbHNlOw0KPiA+ICsNCj4gPiArCQkvKiAiQ29uc3VtZSIgYSByZXRyeSB3aXRob3V0IGZv
cndhcmQgcHJvZ3Jlc3MgKi8NCj4gPiArCQlpZiAobWFwX2ZhaWxfcGFkZHIgPT0gc3RhcnQpIHsN
Cj4gPiArCQkJcmV0cnlfY291bnQrKzsNCj4gPiArCQkJY29udGludWU7DQo+ID4gKwkJfQ0KPiA+
ICsNCj4gPiArCQlzdGFydCA9IG1hcF9mYWlsX3BhZGRyOw0KPiA+ICsJCXJldHJ5X2NvdW50ID0g
MDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gZmFsc2U7DQo+ID4gK30NCj4gPiArDQo+
ID4gKy8qDQo+ID4gKyAqIEluZm9ybSB0aGUgVk1NIG9mIHRoZSBndWVzdCdzIGludGVudCBmb3Ig
dGhpcyBwaHlzaWNhbCBwYWdlOiBzaGFyZWQgd2l0aA0KPiA+ICsgKiB0aGUgVk1NIG9yIHByaXZh
dGUgdG8gdGhlIGd1ZXN0LiAgVGhlIFZNTSBpcyBleHBlY3RlZCB0byBjaGFuZ2UgaXRzIG1hcHBp
bmcNCj4gPiArICogb2YgdGhlIHBhZ2UgaW4gcmVzcG9uc2UuDQo+ID4gKyAqLw0KPiA+ICtzdGF0
aWMgYm9vbCB0ZHhfZW5jX3N0YXR1c19jaGFuZ2VkKHVuc2lnbmVkIGxvbmcgdmFkZHIsIGludCBu
dW1wYWdlcywgYm9vbCBlbmMpDQo+ID4gK3sNCj4gPiArCXBoeXNfYWRkcl90IHN0YXJ0ID0gX19w
YSh2YWRkcik7DQo+ID4gKwlwaHlzX2FkZHJfdCBlbmQgICA9IF9fcGEodmFkZHIgKyBudW1wYWdl
cyAqIFBBR0VfU0laRSk7DQo+ID4gKw0KPiA+ICsJaWYgKCF0ZHhfbWFwX2dwYShzdGFydCwgZW5k
LCBlbmMpKQ0KPiA+ICAJCXJldHVybiBmYWxzZTsNCj4gPiAgDQo+ID4gIAkvKiBzaGFyZWQtPnBy
aXZhdGUgY29udmVyc2lvbiByZXF1aXJlcyBtZW1vcnkgdG8gYmUgYWNjZXB0ZWQgYmVmb3JlIHVz
ZSAqLw0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4Lmgg
Yi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9zaGFyZWQvdGR4LmgNCj4gPiBpbmRleCA3NTEzYjNiYjY5
YjdlLi4yMmVlMjNhM2YyNGE2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3NoYXJlZC90ZHguaA0KPiA+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHgu
aA0KPiA+IEBAIC0yNCw2ICsyNCw4IEBADQo+ID4gICNkZWZpbmUgVERWTUNBTExfTUFQX0dQQQkJ
MHgxMDAwMQ0KPiA+ICAjZGVmaW5lIFREVk1DQUxMX1JFUE9SVF9GQVRBTF9FUlJPUgkweDEwMDAz
DQo+ID4gIA0KPiA+ICsjZGVmaW5lIFREVk1DQUxMX1NUQVRVU19SRVRSWQkJMQ0KPiA+ICsNCj4g
PiAgI2lmbmRlZiBfX0FTU0VNQkxZX18NCj4gPiAgDQo+ID4gIC8qDQo+IA0KDQo=

