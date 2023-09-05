Return-Path: <linux-hyperv+bounces-2-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC1479260A
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 18:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55931C20A1C
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0985BDDA3;
	Tue,  5 Sep 2023 16:25:56 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E236CD30D
	for <linux-hyperv@vger.kernel.org>; Tue,  5 Sep 2023 16:25:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4D93C14;
	Tue,  5 Sep 2023 09:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693931129; x=1725467129;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=33PICZepgZ+319VmKN5o6ykIzG0vwj87QEjbguQmuMs=;
  b=d+zxo6rkCwys5OSSKL2DEFc92FEdOfRNMKGbIkQvQC0tHoQRYfNnCupR
   1kNl4B3LzpQzvnWVDtj+hFMYxcHFbRG3bHDsQtJKi0eVhiCA4fcpS0P1F
   zRVvno4rMMjTRFWUfBBZ7mdr/ggku8EwLLpOjy8Cnu/xKRIY89L0iRLwA
   Il7o0vROpK7SyzCrRYYJFRgKy8YPZI0vlLwFZJMdPGvEMkwRKplmLiTgk
   f2gwBtZkqIqg0Xany4AxkOWTHYxrac39rUWg/DXRt0F8+xtytbxzVRd67
   20HdryH7wxzBJYr0ypatVnGwLk5eg7AQciIQYh4CrKRQ38Gsrj26phxxT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="357149117"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="357149117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 09:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="856055237"
X-IronPort-AV: E=Sophos;i="6.02,229,1688454000"; 
   d="scan'208";a="856055237"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2023 09:25:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 09:25:04 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 5 Sep 2023 09:25:03 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 5 Sep 2023 09:25:03 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 5 Sep 2023 09:25:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xgn+P/eFGZR+9UnIkq/A1zIcriz92A6Iuayy0Bt6eaDQghwKnVpRa3ap3I91axCuJLwsumlOw2040eUXIxpFtnjLcxPt6dXfTl1wbS/KMpJTcWqLc1trzuNlTSveOwQ8VQJxpnjoaapyAJyisPVB5rTw61v87uLEXjk4HalEdVHx/42hTurvvMxAGmprB4xabyQeIZIYMhquFDP0zIUc74qE5wTXHqUHGKLjK2PcV+2CJLoJAmdTUUG05tLkTi+Cdc122/fo5/yVPPe7vxAL3vk6fbwqrpJknwsEol9jyMwfg8J6nZsq6ZrpjRZlbLE/yvh0SvW5i1Xteqp7b0+cWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=33PICZepgZ+319VmKN5o6ykIzG0vwj87QEjbguQmuMs=;
 b=QAZYipv/L9qMrqp7tX3dgF1tYAGmU1V/zl8owYzO/lE1vPfACzpZ4WoSj1poLqQAedSYC6vnLNwUbGz6JT2PcYMIoig+9xPGeKne53NempGWNYw+Y2W01nAdaJdU+Ua18Wm97tMjqDwKwVPe3GDnJfWxELss3mTyrsMkzc34MXpUIdEsCd5QClYWpD0cGxNlReFxD4mVu6WOPC8Smb3pgkXTYZRc36fJj1IPnOhVWvk/sIPJlIsztzHGN9dlvJwieWmnnd5dfohY/mH7N7R8nFfoZp0sWDEcCAWQUWFbTBu57pSZHc02XTzAx6nZ9nl3ngPnDOoPHKdvZxYhjc5B+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8707.namprd11.prod.outlook.com (2603:10b6:610:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 16:25:01 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::abd2:f781:1433:259%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 16:25:01 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
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
CC: "vkuznets@redhat.com" <vkuznets@redhat.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "andavis@redhat.com" <andavis@redhat.com>,
	"mheslin@redhat.com" <mheslin@redhat.com>
Subject: Re: [PATCH v10 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH v10 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZzJ23VWbZscw9EEKPl7FjsLjo4LAMkcwA
Date: Tue, 5 Sep 2023 16:25:00 +0000
Message-ID: <e8b1b0b5f32115c0ef8f1aeb0b805c4d9a953b31.camel@intel.com>
References: <20230811214826.9609-1-decui@microsoft.com>
	 <20230811214826.9609-3-decui@microsoft.com>
In-Reply-To: <20230811214826.9609-3-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8707:EE_
x-ms-office365-filtering-correlation-id: 0c5ce8d9-02a6-41dc-834c-08dbae2ca72e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XPjmaEaPMEWgsS7PK8c9L25u6KjZdKRh6Ui98TDJZlkiXvWEXL9XAshcIZQ8UGRng1qmtcld1ncpGTrYH7AtmiCasozTbnQHU23FzzA/NmvOsfqVzsvU4T6vPNpITWkbwOptELbzjiQUF3QHQ0KdqCqhZnijoXGHwGYIPBWxZGVX/tPW4E85Rbkox5+GTXyC1WCr06SrNpAlORF57AKOalfOVNbidvRqn9/uajp+PRrMgpI6RNIXipvkhwXyijcB/hQj9tNvnytBbxwr8Ulr2EBqNNIztQRWGawiFK3CdTTvOIduo2+U1luvR7exaTM6D8U54S2mMN9eRQlIqS56VU6RLEc5GrW6xbTm5dD4nahJ5dfcIGkWiOjNEv1LoE+5L0ri8oCBJfhim8kcp+Uno7CxojsZE0EYtSLtBjIPR1ct2hrFhH5MHYYPNN1imwQRN+o84wHefpi5Dpql0omspeEWnoSjuJlV79L86XByBSQZvX02GQmI4DZPZ8/v2czZi8J2Rqf0mIVsTgPCmSv4uRxe3QT5D/STc99sZdtJHFyL7mrwXjiW3R0NBJXwWnBmmN0G0kB/eAhgCf93d2m8vaJmbmabGN3IVT6Lmy8Oo4XTotTR50V8uCMR0KowQZ4LkM0TXQGEu1lZHBPiZsRRFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199024)(1800799009)(186009)(66476007)(36756003)(64756008)(76116006)(66946007)(91956017)(316002)(110136005)(2906002)(86362001)(66446008)(54906003)(66556008)(8936002)(5660300002)(4326008)(8676002)(41300700001)(6512007)(2616005)(83380400001)(26005)(38100700002)(38070700005)(7416002)(478600001)(921005)(82960400001)(6486002)(71200400001)(122000001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d2xPaWpJcGhsdU1Jc0tSWjNVNHNRZGVhNEdQRXhYTUdMZUoyem9KaVAxNHlJ?=
 =?utf-8?B?Q01ER1cvYXFXeHliRVNselE1WllaN2FQYWlhWEFqYlBJNFBVUG01MlREaTZj?=
 =?utf-8?B?dnhzOHdHVXFVQTFHbUh4VTlRQk5qbHp6bkJDSGZjbHpwT0M4YkNxZVcza3dh?=
 =?utf-8?B?RkM2eElHUCtlQ1JYa0UyVzJ0Znpxc3J6Q1YxSzU2MUNSRkZMdUhBMjRwS3NZ?=
 =?utf-8?B?T1BQK2tiSExiK2NmOXhwYy9PYjB2Z0ZOeHdqaUlZVjNFQUUvd1RpQWwzOTZx?=
 =?utf-8?B?MmhVSGppSWJmUHQ0Y2NYc0pkRmxtUWFWZmxSZEpNTUpZZDRXZy9OWlBJT0dp?=
 =?utf-8?B?Z1JDL1QwY2d1ZGQ3YVMvVWFPMUZsa0tZd2w1cFFKTlVTSDVwdndlWnBraUJB?=
 =?utf-8?B?RGZlcDE0K2R6b2pXZkM2cFBnaEg3QTI3T2dYTUlrZnVWN25iS1ExRHZJM0V4?=
 =?utf-8?B?TGorQ0YzYTlta2NQOStDT0JnbDc0eXNWZ21NOUc2M2xPVXhMNjltU1RDVlpy?=
 =?utf-8?B?NXBlb2RSZ0FVQXFqWHVCUERwZWQreDQxYUl4MG1vVGE2dy8wNmNINUx0UkFK?=
 =?utf-8?B?Qlg3ZTNUYnNlaUo2VE5CRDlyeDhuSjFFS0JmVGhJS0tFaityUXVlUVM2aWJ5?=
 =?utf-8?B?RGxPYmYvUlh4NlJQMTdkMHg4SmJ6RFIySmVwY0xRZVdOWVZHc3lmdjlBTW12?=
 =?utf-8?B?a1piMnF0WHpWOWtSckRVR0tIcEJPd3dpUE9DcWZLMW9OWTMvVlVVMkZTWEZi?=
 =?utf-8?B?NENWc1RvNDczMDVUZnIxMEhwQTBvYzNwTm9Bb3ozd0tFN2wxU0NhcjI2dWJh?=
 =?utf-8?B?clg5UDlZN1Z0Z2VpTDBySkhubjZYMkF4K0txMG5BbW9yOHlvQm9lY3RBV2t1?=
 =?utf-8?B?QmMrVERPbkM3ZFZmWUo2RTZCcGJOTGkrT0Nud3dhcUFpOXNjVCthTG1wcEF0?=
 =?utf-8?B?WktYTzlsWHpuNDlIMk5IMy85TDV2UGljdGFKdmpZWGhHdHRpTm1BbERFNFJ6?=
 =?utf-8?B?ekIvM0tqSUNXaCsxZ0R1dTRSREZEZUpVeU1RbW9Fb2w0VEEwNWlCNkhoYU5N?=
 =?utf-8?B?My9DLzVxVnpXb1NYSm9pekg3ejdrSk5GeFovdjAyOThHdHB1QnpNdGFFRzFH?=
 =?utf-8?B?ZkJSYVRhWGI0NzEvVDJJL3d0cjJjR3NKdDlDRWpUc0JEMVp0VXBOZkl2Mm01?=
 =?utf-8?B?UkFJNWlWZVUvWVlQdkZ0cWd1M1JXZVpINnhQRUZFbGZhdmJLL1RVYk9kRzNn?=
 =?utf-8?B?Vmh1UUhKMWdxRnc4NEtwa1lrMkNPTldvZjFUcnJEaFhDV0kxQjNRcGxidEdO?=
 =?utf-8?B?eG5rU0VkTjBNRU9ZTUU2bzBxc0Z1a1E5RGVtdG16M3hkV3hhQStuc3dRQXJ6?=
 =?utf-8?B?QW9jYkEvMy9XNWxXVzNUQ3VWbG90YzBQaXo4OFNjV1BNV094QlJvMnpqSDNG?=
 =?utf-8?B?Nzg0NzZYdUhybVNCNHNIbzRxNGowUm85MXU1L0o0ajl5MndGemVMaGhoVDFQ?=
 =?utf-8?B?cXRvVFNLZEF6dmVsNndMY1p3blJ1TW9UQmZEZ3pwSk5NbGRRYUVVZWJuTGJ4?=
 =?utf-8?B?NXJNTUt6L0RtdXNwTldQZVVtZ05SMUUwNEtsQUJPeHRONGU3UFZDVG9mTWha?=
 =?utf-8?B?RmxBSVZEbm15R1NEdFRlS1ZvSE1SMCt6WVYrOThDOFd2bm9GTXk3SlpqdnRS?=
 =?utf-8?B?SW1Nay9lMUt1ejhTbXZ0SUFyeklJOXhkYjcvU0U0MTBtSGZwQlNTZ2FXcHpR?=
 =?utf-8?B?T09mN3VzSkNCUkoreTRiN0dwYjBJNDIwdS9QNTlETE44S3R0eFkyUGlIMDd5?=
 =?utf-8?B?MEFIUWtpUE9QUE9nWjR0QVk0d25MUm0vVDA1K1FmaGVDNUM1WUx6R1RHb0hK?=
 =?utf-8?B?R1g5SzAwdG9lUmY1S0tMRUwzWUlNQzNxUmgyVFdBUkRSZDloNHQ0V3VKS2VH?=
 =?utf-8?B?dHczc1BJUTZPc242Wk1aRmlzdVQ5S3BoZ0JIVEtYTnAxdmtZdzJSMzhhRFh0?=
 =?utf-8?B?OS9qOW9GMVBzMnZtYmxaQWRtRThlRWJDOUJ6VFJmYjRpTU9FQUs5Q3JpK1NC?=
 =?utf-8?B?VzlNalhXUGxHYTl4OEVzTWhSZ2NsUnpkWE0zVmJaYU8vVi85c2gzVGdzeWM4?=
 =?utf-8?B?bTZPeWVqQmVER2tEdEo0cHpVWVBzTjFhTDdzNjBaWUpBYXJWOEFmekQzMkdw?=
 =?utf-8?B?SXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F452BA77D7FEA045A9D18D15C2328E0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5ce8d9-02a6-41dc-834c-08dbae2ca72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2023 16:25:00.9568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oTtCwFksAqhqSCTqrBW04CYHxOrRTsLmDhINLqGMxd6RDLaFwfMZktWyiloJ7MNvR+RwQFNt7fkHKX9veRjH4zxmFNtEDiqX2MOUsjxaXP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8707
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

T24gRnJpLCAyMDIzLTA4LTExIGF0IDE0OjQ4IC0wNzAwLCBEZXh1YW4gQ3VpIHdyb3RlOg0KPiBX
aGVuIGEgVERYIGd1ZXN0IHJ1bnMgb24gSHlwZXItViwgdGhlIGh2X25ldHZzYyBkcml2ZXIncw0K
PiBuZXR2c2NfaW5pdF9idWYoKQ0KPiBhbGxvY2F0ZXMgYnVmZmVycyB1c2luZyB2emFsbG9jKCks
IGFuZCBuZWVkcyB0byBzaGFyZSB0aGUgYnVmZmVycw0KPiB3aXRoIHRoZQ0KPiBob3N0IE9TIGJ5
IGNhbGxpbmcgc2V0X21lbW9yeV9kZWNyeXB0ZWQoKSwgd2hpY2ggaXMgbm90IHdvcmtpbmcgZm9y
DQo+IHZtYWxsb2MoKSB5ZXQuIEFkZCB0aGUgc3VwcG9ydCBieSBoYW5kbGluZyB0aGUgcGFnZXMg
b25lIGJ5IG9uZS4NCj4gDQo+IENvLWRldmVsb3BlZC1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxr
aXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLaXJpbGwg
QS4gU2h1dGVtb3YgPGtpcmlsbC5zaHV0ZW1vdkBsaW51eC5pbnRlbC5jb20+DQo+IFJldmlld2Vk
LWJ5OiBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuDQo+IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVz
d2FteUBsaW51eC5pbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IERleHVhbiBDdWkgPGRlY3Vp
QG1pY3Jvc29mdC5jb20+DQo+IC0tLQ0KPiDCoGFyY2gveDg2L2NvY28vdGR4L3RkeC5jIHwgMzYg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDMwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQoNClJldmlld2VkLWJ5OiBSaWNrIEVk
Z2Vjb21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNCk9ubHkgc21hbGwgY29tbWVu
dCwgaXQgaXMgcG9zc2libGUgdG8gaGF2ZSBodWdlIHZtYWxsb2MncyBub3csIHdoaWNoDQp3b3Vs
ZCBtZWFuIHRoaXMgd291bGQgZG8gNTEyIFREVk1DQUxMX01BUF9HUEEgY2FsbHMgaW5zdGVhZCBv
ZiAxIHdoZW4NCmVuY291bnRlcmluZyBhIGh1Z2Ugdm1hbGxvYyBtYXBwaW5nLiBJZiB0aGlzIHVz
ZWQgbG9va3VwX2FkZHJlc3MoKQ0KZGlyZWN0bHkgaW5zdGVhZCBvZiBzbG93X3ZpcnRfdG9fcGh5
cygpLCBpdCBjb3VsZCBjYXRjaCB0aGlzIGNhc2UuIEkNCmRvbid0IHRoaW5rIHRoZXJlIGFyZSBh
bnkgY2FzZXMgb2YgaHVnZSB2bWFsbG9jcyB0b2RheSB0aGF0IHdvdWxkIGdldA0KcGFzc2VkIGlu
dG8gc2V0X21lbW9yeV9lbi9kZWNyeXB0ZWQoKSwgc28gd291bGQgb25seSBiZSBmdXR1cmUNCnBy
b29maW5nLg0K

