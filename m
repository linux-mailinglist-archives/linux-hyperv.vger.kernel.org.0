Return-Path: <linux-hyperv+bounces-6-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DDF79335F
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Sep 2023 03:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6BA1C20938
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Sep 2023 01:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C2634;
	Wed,  6 Sep 2023 01:27:45 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8B62B
	for <linux-hyperv@vger.kernel.org>; Wed,  6 Sep 2023 01:27:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDB91AB;
	Tue,  5 Sep 2023 18:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693963660; x=1725499660;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ooRUsdC7B4DrJigEHLXRH6B5+DFNGiFTDhriF9GC/4Y=;
  b=Vxzt0dhWeL/VUfeiS+1yMFUR6w6FG0A9MM6qqov3iOTBO1KI2cBpreDB
   DUp7ZLKCzZwsyi/7Qm8HhtlnyAhfd1yilX4ZM2p2lgGidA38zeP9dtrbV
   9/nXBQLkHqDlMYYVL4YoX6ljSfuHPur2S1p2Blgd6POqGLpBHyuxqgpFp
   QFFekaWOm7CHO2Wyeh4X5b2bIwwl7uMbPkxpUnudziBE5g444k2rbIqiE
   vBDv0x+o5En4f8VKADPW7Y5WtHsnmyA/fnmjkUCbMF7SPCfnOQ7ElTiPo
   vliSforSigLKXetgaRRAbrvku81DOx7WVPtH1jnxu80f3r9Et+IK5h13C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="361972419"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="361972419"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 18:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="856221289"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="856221289"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 18:27:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 18:27:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 18:27:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 18:27:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEU6Wy5KUaoyl0BwzpKFMOQdVf9qBntjwKWJMekl6Z0SyLQ4UTlt+bYooSiXdxTB8HKbpGQBQZ/I3H2qnu0pb0WrvpGD5QhJTSQgtJ65XzdsV3r2u3RQzmpIsMbgSYFaOP4LjToEyzZWs3an72yY2byooWzxa4nOrICMRoTI3/ObPVixVp5vv3N8hfXH0zhjyxcZQMgPr3x+KXCBUvrjfY8y8DxjIolmqavOl1XjyeHC7ZeOPL6SC4m3amd8im/1fTw8elh55CPgQ28HYSe/m5NEIoE6eSr50zthHLx/pfGV09hCv2j5CUgCli0kyfopPGZi5z2H2zh5gYR7ofDfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooRUsdC7B4DrJigEHLXRH6B5+DFNGiFTDhriF9GC/4Y=;
 b=A6RJ8VT7/uEn2MmALUPMbwBPvyP9ytjx/uYmQrImh5uuKBK88nyci4GLr9JLSL6ii9osZwjB0gizsmpV6lrd4+Byu9MCqTmtYwVEPKwBaSF4EHNL6wcotgaM3z1rSBxudWxXcDYPggGyvOoCtqDnSxwbzF9OycXy2t3UJs35joo/U7tQyBQcfjD/ErT11JUWynv3r2srPopkOYcYLf2s7R7xzXwZnuhwUeoZvlWy9TuHgF1WoxKhg2UBD4dRJyud8aIrsGTV26YVwpsQuBUnsQbPDgzutvXDj4DDGI4t1ew8z6YMubNaJriBcgq26JSdubt5wiCizYaPF7C+bu3rIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM6PR11MB4562.namprd11.prod.outlook.com (2603:10b6:5:2a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 01:27:36 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 01:27:35 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Jason@zx2c4.com" <Jason@zx2c4.com>, "Lutomirski, Andy" <luto@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Hansen, Dave"
	<dave.hansen@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "ak@linux.intel.com" <ak@linux.intel.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "kys@microsoft.com" <kys@microsoft.com>, "Cui, Dexuan"
	<decui@microsoft.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "chu, jane" <jane.chu@oracle.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"Luck, Tony" <tony.luck@intel.com>, "Christopherson,, Sean"
	<seanjc@google.com>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "brijesh.singh@amd.com"
	<brijesh.singh@amd.com>, "Williams, Dan J" <dan.j.williams@intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "mheslin@redhat.com" <mheslin@redhat.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, "Li,
 Xiaoyao" <xiaoyao.li@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "andavis@redhat.com" <andavis@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v10 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v10 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZzJ27wUNDWeoYfECMFvG+INiQaLANKWOA
Date: Wed, 6 Sep 2023 01:27:35 +0000
Message-ID: <6b6e7f943b7e28fa6ae6c77e1002ac61c41c1ee2.camel@intel.com>
References: <20230811214826.9609-1-decui@microsoft.com>
	 <20230811214826.9609-3-decui@microsoft.com>
In-Reply-To: <20230811214826.9609-3-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM6PR11MB4562:EE_
x-ms-office365-filtering-correlation-id: 680009b5-f03a-4125-831e-08dbae78736f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rEk320zhTWd3c1T2E5BH7gLhm3r/VBlWOXFkqHEcp3zf+jxnX6t4nAuw6y//64G3zIBj7urVfe6Msyd4ZcKe//ETShhrPvJH2PJYoQYYkGz7jGcv9W6oZGKaCEtUvBwq/CTqFLR2kptzdlpL3CIbEL1UjQxHF9N4HFKPpwnzgBXgLWcLClpbx+i3RomNIAeNFhjdAVVHCyrcPYDMNPPQXNzLGVF3ers8kTKwqFSsQIsTzIKdORvyBnaTkpyxdMiX8WouB6jmotQNEzkax6vWZMVD6QbWQseldYfoNvuj21Oe2r/XNxFtce7s/YCX9rTtsAZJonkRVZwkiAYm04mZ7DXUOWjl+2vm/ItSFBA/ncxvYgtONlsWdzS0F/+49muWKs330dJmHvOBIXeY2nxcRA/qfFMQR8UOAmkfeLU5rm2b9Wc0t9+gtitwb4N1aGTp+yhJ9TE2IsZjfVTu+gtFjvICwznl+2TJDn2GzEzhradJFSF+FrY+rR/qV5kHXOYfNwMf/ZpVlT6YP4wXb5yV6V974zipN3QLfeH9KdU6rUKakUYxcbUtU208c6KMIc9KlVWjKuJkOzDO92RERlETFt5iNU4xInKGoRAYNS0pIi982D3DotHzIipkjo47iLcxUK0TlKlDs82MOio+a2rxPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(186009)(451199024)(1800799009)(122000001)(6506007)(6486002)(71200400001)(6512007)(478600001)(83380400001)(2616005)(4744005)(26005)(2906002)(7416002)(66446008)(66556008)(54906003)(64756008)(66476007)(41300700001)(316002)(66946007)(91956017)(110136005)(76116006)(4326008)(8676002)(8936002)(5660300002)(36756003)(82960400001)(86362001)(38100700002)(38070700005)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGN5VTBQZlp6eUk2V1Q3N0wyWTBOdU80czVWZnk1ZVg4alVqN3JIbVdFZUta?=
 =?utf-8?B?cytyaWVpbnF5Ym5VMDVJWHpHL1pHN3MrZUZtVXlIcmRDN1IwbmVVNm5Xb1li?=
 =?utf-8?B?NjdEMWxlNTJ6VVZNY1VYbThYZnJjMTdzQnhzbm12MWdEYUdEMnM3ekpqaHp3?=
 =?utf-8?B?VkZoeFJ1NDJjbVJ3U1RLWURNcEN6UTFNU1pFc1JYL2ZOOWZKU2Y1OXc3aElJ?=
 =?utf-8?B?eXl6ME54ZHlTdm50V1VycE0wd09RaWNMK2hYQzZzYkZkaWlEemM1YVNrVkhG?=
 =?utf-8?B?WXhBSHZpNXZ6N0NtSEZ4eEtxbmlCc0pMV2s5cWJKLzU5YlBVelcwTlRCSW0z?=
 =?utf-8?B?UTVpb21qZ3hTbGJQQVNYSkVVRFdXblRMQjdHcERjZXVXU3R0UWozaERaT2Vx?=
 =?utf-8?B?eGtDNE5Hb091Ym10TzhXbk1jTE5xUElTS3FjT0h0V1VRZTVSR3pWV1ZYTi9h?=
 =?utf-8?B?VzhDYnE0bHkydTQ4MnpqcE1MVFh4eEpHRW9lbjl2cG5WVnIycllGOEpTdEVz?=
 =?utf-8?B?NjdjY3hsVmNYaWtHL1BUcmlsZHVsa1EzWlYvekZWeEUxeUFDMzZJTS9FbllZ?=
 =?utf-8?B?SjFPNU10VkgrYUVuY2VlK2VxNXk2dUpwd2ZsaHhGU2JMZVpOZ3RWZUVMdCtZ?=
 =?utf-8?B?VEoxZXFXVjhIdXJIRllnUEdHSlhGMUFwb002VmJIdnVEbDE4N1FIbW1xR3o5?=
 =?utf-8?B?cUpPR0lUL1VYQktvd0Nsa0RSaitkMjl4NjNSc2VkaW1IRmZhU2NqYlFsR2ZP?=
 =?utf-8?B?WE54NUtpNVZDK1dvVnQvNHdtOG9JTkc5ZERVTERCUmNXM2VRK1R0SldQQ2Zt?=
 =?utf-8?B?UEtrcDhWUGU0S0lXajNtbFk5OVdTTDZvaGlmSjJmZHhrN2szdWlkNHdjempD?=
 =?utf-8?B?ZjFSbm9OenI5YVoxU2dLaE45N29zdjJDWjdTelQ2WjhuWE5TMFFDRUJFTHlk?=
 =?utf-8?B?RmVhOVZUZkhwelA4WnRvZjRsNzZZNTlQN3dyZjVKcWQyc3Y3eHhJT2N0VE5u?=
 =?utf-8?B?NVdQTjcwRHJIQW1zU3FpdncvVVR4SkpGWnVuS3RkWHlSMEo3eFhhbDFtaHZD?=
 =?utf-8?B?V2RiMDM3b1NEZlI4Y1l1MzAvQVQySDNIRzVraHNMZmdOSTRISW9wSjBpYVB5?=
 =?utf-8?B?LzI1SWRBKzM1NlM4RW9XcnhYMkpkNjNtWmtDcGpjbGhOWE04UFhaY25aUU1Q?=
 =?utf-8?B?NktaVC93L0c3RTVnZnVlU1B1QjRlUDF2LzVHa0pwd1JiY1VCNEdEMys4OXZH?=
 =?utf-8?B?TnFzMHpCckdhZWRRYkRNZWpQQzk5Ri9IaW82ZVJhcHMyTHR3ckVYMTNCM2FW?=
 =?utf-8?B?b1NTUjVLSW9Vd1hvTEU5UWZrMHJ2S1R0RW5SR1lsWUNZZ2wyMmJvTDJ2dk01?=
 =?utf-8?B?Vk4yTWxqeUJmUHA0ZFhjbElBOE9sT2p2U0pVRTU5OVJPT1hjYW82K2paZ0tV?=
 =?utf-8?B?SEt5M2NMSW5ITVNaaXpQQlJ6bHBIL29xWnpTOWVqTTA2SDZyT2N0bm5RNi8r?=
 =?utf-8?B?VG5yQ3BYbFN2RzJIUUpCNnQyQ2FLQnIrQm9UV1A2bGtYdFVmN3dRUWl6QmxU?=
 =?utf-8?B?SXBnOVI5NXZ3QlQ5d05vb1BTUUhOcG05dFB5aHI2Y1NmR1BOQ2FTcVN4K3JV?=
 =?utf-8?B?NHNuckJMTXhFaHI5Z1Q2cGFSR1hEUHhlTDc0dTVFQldSNTREVVdxTE5tQTdw?=
 =?utf-8?B?dG50ajZaMml2THdLako0L05iN3VJbDV3bWc2TTZsMitsMTJzblJHTDY0RHpj?=
 =?utf-8?B?ak9VaVZBaGJqWDdUN251WGoxZWFRU0twYkwvYUt4cU40UFpEcUZRanFJZ2dG?=
 =?utf-8?B?QnpnZnJnd0J3UmlmVVFobnpZVWRjTmMrejhQT3phMnRsUWVvRmM1Qkswa0ZZ?=
 =?utf-8?B?dHpaRUcwMXIxa2NLODBTem10UzNqSHZPcnlFYTZQTnVMNUd5alE2ZFJnOXJ2?=
 =?utf-8?B?L0p6cGQxVGtpKzRZT1I5S2hTTlhYVUFzUTB2MzFVSWJKeG5WQzdpby9SUGIx?=
 =?utf-8?B?RmNlN0FYamVINHVWSGJPWDBySXZRRTdZSnN4T3FDeWorVEFyRHJpc2JPNFg4?=
 =?utf-8?B?bDd0a25WM0lWWFZ2YlNwZFJIVzRwWjRtbkp1cE4yc1FBYzZraFFybk9IWGpZ?=
 =?utf-8?Q?bGNU8JsTYPHZo6aO8V7B1BiNB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F41C046FD5C2641AF24053D448B0E7E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680009b5-f03a-4125-831e-08dbae78736f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2023 01:27:35.8458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nyPNvZxOwmBl1bXm53VCxKHNIokwWA8cJxYv2HGgM8Gd6nIHl8EEzBNsSxwERD3udSGjHYXHcEt6QB0MzyWIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4562
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCAyMDIzLTA4LTExIGF0IDE0OjQ4IC0wNzAwLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiBX
aGVuIGEgVERYIGd1ZXN0IHJ1bnMgb24gSHlwZXItViwgdGhlIGh2X25ldHZzYyBkcml2ZXIncyBu
ZXR2c2NfaW5pdF9idWYoKQ0KPiBhbGxvY2F0ZXMgYnVmZmVycyB1c2luZyB2emFsbG9jKCksIGFu
ZCBuZWVkcyB0byBzaGFyZSB0aGUgYnVmZmVycyB3aXRoIHRoZQ0KPiBob3N0IE9TIGJ5IGNhbGxp
bmcgc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSwgd2hpY2ggaXMgbm90IHdvcmtpbmcgZm9yDQo+IHZt
YWxsb2MoKSB5ZXQuIEFkZCB0aGUgc3VwcG9ydCBieSBoYW5kbGluZyB0aGUgcGFnZXMgb25lIGJ5
IG9uZS4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwu
c2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwgQS4gU2h1
dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2VkLWJ5OiBN
aWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEt1
cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuIDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51
eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29m
dC5jb20+DQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQoNCk9u
ZSBuaXQgYmVsb3cgLi4uDQoNClsuLi5dDQoNCg0KPiAgDQo+IC0JaWYgKCF0ZHhfbWFwX2dwYShz
dGFydCwgZW5kLCBlbmMpKQ0KPiArCWlmIChvZmZzZXRfaW5fcGFnZShzdGFydCkgIT0gMCkNCj4g
IAkJcmV0dXJuIGZhbHNlOw0KDQouLi4gCSIhPSAwIiBpc24ndCBuZWVkZWQuDQoNCg0KT3Igc2hv
dWxkIHdlIGV2ZW4gV0FSTigpPyAgSUlVQyBieSByZWFjaGluZyBoZXJlIHRoZSBjYWxsZXIgc2hv
dWxkIGFscmVhZHkNCnZlcmlmaWVkIGJvdGggYWRkcmVzcyBhbmQgc2l6ZSBhcmUgcGFnZSBhbGln
bmVkLCBidXQgSSBkaWRuJ3QgZG8gZnVsbCBjaGVjay4NCg==

