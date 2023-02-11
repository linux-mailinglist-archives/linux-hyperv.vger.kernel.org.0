Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A35692BB9
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Feb 2023 01:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjBKAGU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Feb 2023 19:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBKAGT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Feb 2023 19:06:19 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E47CCBC;
        Fri, 10 Feb 2023 16:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676073977; x=1707609977;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1+f4QBcpN59TQ8NjHjhFmaLNd5JqBHEgtwqaH4WDH0g=;
  b=El/m29lajDYlRjo4cvVrV1i1vohRSlZU/JkaEdtjMKbu+J/PhER/l3bE
   w+sSNoL/cu5fca+y+Jn0TnwgG0k44hDpE6W3Qs18uU1AWjElOPCDWuzR5
   VmfKJ8JJcpdB+gsUWeeNqa8QT72KOnxP64qhQMHEyD0FL2ZK6sdj7c863
   eunzrTksDqDCMWOJE8lB9Rq86tGYuukHUKSOrKQVerUmZUxaNQBljJWFC
   gIyUT+pu1uFCtUZXu9RlxRHXzqTp/EOMZ7Qc9X+OWI7B42ZSEqr+Nc7hT
   MnW0SRq6IgXLuy93K81VSVqF/rsKjFg/VpChG5qTsIDOLsGONkUOmwALE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="331863665"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="331863665"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 16:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756956906"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756956906"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Feb 2023 16:06:17 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 10 Feb 2023 16:06:16 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 10 Feb 2023 16:06:16 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 10 Feb 2023 16:06:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fuMW1FFVU96A3zS+9WSXt6hl7KGxsR0S7QGs6DOZ71shMF9/ChDtw/1LlUWKQpqDfMRWoNstjvvKCnHXWBJMmUTmtx3sL8dKKv3A8po0HU0ymZ8fF14SkDl8DA74auOlAsxAJce5ODaWXqQ5MpYJacAqZcphIQVI+aGp6sK6wA/FBE70GV+Lvrixi1NMWy3FTerBzNamy58diUSUg5Qs4p3dhqmlYTCYiBmjWgueCyf38QuRVoh/12Wm/tKZkbyl6cg2tnoRkXYgsheGlVrepMvoQ5OxShIQVlrMwVxKMUWZ9s7awQ4g9/kIZpiEUf2R2PAza+sYPU6SDNqryvAL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+f4QBcpN59TQ8NjHjhFmaLNd5JqBHEgtwqaH4WDH0g=;
 b=jp4vcMAX3r++wdyrYLRDhklJe/jMfaEEcQILOnbyVQV/s6MOuWo81XFUPjs/+PIThGaKSNjDUgaOJCAJX/aHnuAYO0zurxAZRkKV2p8kyabLq2UjzsybfXhPd2mc3XvP+SpHBCBWcgTW7Re5IN/6tuu60KPoySmDnEhdZhPZmESDNnrKMUuq8Hz8ETAiN0Y+xgjB5MkASvYjiqB+6Ms8b0cXPdhNYMV14mTs2257SxKk5xS0cM5tTITJHizzJbOGwKmj0Rj6tydp8m3H8mBoHWRblPRpaEdtFOMLlq62HezXUQHnbdCdXU1bzg/W3snH4Mu+q9koUUh8mP+aVR5L7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY8PR11MB7267.namprd11.prod.outlook.com (2603:10b6:930:9a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Sat, 11 Feb
 2023 00:06:12 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::d41f:9f07:ed56:a536%3]) with mapi id 15.20.6086.019; Sat, 11 Feb 2023
 00:06:12 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gross, Jurgen" <jgross@suse.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
Thread-Topic: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
Thread-Index: AQHZPaym1OeQ0uPDs0uotDA3o+cSyA==
Date:   Sat, 11 Feb 2023 00:06:11 +0000
Message-ID: <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
References: <20230209072220.6836-1-jgross@suse.com>
In-Reply-To: <20230209072220.6836-1-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CY8PR11MB7267:EE_
x-ms-office365-filtering-correlation-id: f49b9f44-5d88-4e61-dc95-08db0bc3c8d8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9uaqAUg7gYxRXI58MgbrQWbg/ndyPjD8yWRG9k9+MoGpDym+4aQp0mwV7yB3qdGIpL63cPkxUi5RoXcX8LSuUztej9LyNRwXHolmj91Ry+FSa3WR3LEQECzOjg8BTZ6uZIv8YlEW5iymysfbm8NcSHchBhHnRXRyYAiim6lN1wx1bvVhx6WIql02/O57mCtcyRdO/bIsSr1o/9HiDW02K8GQNy9e0j/d9nTTwb8SzhIZnBanJHNqE312Bx8ak7QBHzSroIicfOCbsfJwsOTkS41Jonz6iv+FrBrVmi5+twldzZJOKcQVcOL4BQdqXuYyV/szYllfXeUpkvhn6tpreFGvI8LnD8TLEoTHaBDlkfDjjriYjSkkJtHBOlyvGNN6KTMuVt7YqZLoNG3xdgy8xwEX22p5dMfw7T/jFpkIDrM2+gLGCGR5peMHZQZWxiZDTArsuHy0KeivVghmPvxX3cXVN7TCGzfilt9i0Hf6ICHI84PE600sL0PjhPTeA/szSoEE1+kO12XGx5Mi4sbBV1nBBAlBS0QjflZaHoYg+9Mq/L5R8O3bG645g/2PZ+3vsikLgfFO90AnJIdlclM+i6EunTi8LUgsFI/k5r9jFB/sm00VONcHYdEQFl5p/0xVmL6qXl6CWbYhfIqtvKzm/1LdUtWXFAw+C5urkdpehNEAbrHg99LvLq805l5fXv4HstauPPBs5PAxX5/NY46JVFTBQmalvtzoKiBPmrICFY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199018)(36756003)(38070700005)(122000001)(38100700002)(82960400001)(26005)(86362001)(6512007)(2616005)(83380400001)(71200400001)(186003)(6506007)(45080400002)(478600001)(6486002)(7416002)(91956017)(316002)(110136005)(8936002)(41300700001)(66476007)(5660300002)(54906003)(2906002)(64756008)(66446008)(76116006)(4326008)(66946007)(8676002)(66556008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2Q0SUZXMzAxb2VHcThLZDFwSEpZUW1Mcm52UWFTOFdPTSs1L2ZzM1VSQmJW?=
 =?utf-8?B?aktPZFR2UXN0ajZob2lnTFpyay9TdTBKT2tmQklqWmxwWUM0eTBOZVZPNUN3?=
 =?utf-8?B?U0NmRk9rVXRxb053Y3RycUFrTWVUK0Y3ZkFFUWJJZTFEUGI0eFlhbzRqVmUv?=
 =?utf-8?B?N0FJT1VZUkxlOGRvcUx3R1dwdlZGZEQxaHBMSWl1cDJkOXB4SXMyV3R6OUtz?=
 =?utf-8?B?RGVva0liRlZMc3Frd2U0d2NtY0JJNGdnMnBQRkg1TW9OcUU3dnlUc2RSTWlK?=
 =?utf-8?B?dDNNR1pSZmI1ZWw5OUhnODZNTTJ2dDZDbldUZFhuZVh0S1JVZXgvS3pmR2I0?=
 =?utf-8?B?TW9sOHdFVTRMQmRGSmhuS2ZVUUhoU2k2TmhvOHJuaXlyUmh5N3prWjZKbzc4?=
 =?utf-8?B?N0N1Zk9nL25wajFhVDB5TnVhRlpKZGZ1V2JnUWZqbGFsd29RT0NHc21SY1JG?=
 =?utf-8?B?a2x6WmFHNGdaTHdsSXcrcmozWXM0YWd3QSs5ZUhMK0w4NjZXb1g1bzladURO?=
 =?utf-8?B?bDhhaG5OV3QwcTBPQ044N2h0S081VGFpQURCVFdOR2o5amxaVXQyNW9YdTVo?=
 =?utf-8?B?OEIwMitobVZsbjNQVmVMMjZFOVhUNEs4Wm9aQXpTQTZyS2hRMWNKZER4bUQ2?=
 =?utf-8?B?R1pBakg5ZXBjTWcxc2xTeHBYNkkxemlwRm9Pc2VvZW94cC8rOFdqeThBeDUz?=
 =?utf-8?B?N3k0YmtRRnlLOFp2WW1iNW5wSys0d0tjZTVKTTVIcm1zNXgydWM0ZzNTYS9n?=
 =?utf-8?B?ekRNL2dCNW41Z3hwZmhPTVJDZVdaOW1QTTFsQWU2bVQ4T1Y5N3VHaFlwcitq?=
 =?utf-8?B?Nk43S1NwaVNqYk11bFNjTnBKZGFBcDB2dGF3d2pIdmRWQjg1VWk1VTBvZUx5?=
 =?utf-8?B?OUh4OVEydWFSQUdlZTIrcWpTeExUVnIreDBNVWMrZ2ZiUlRuRVAvR2tWcEx5?=
 =?utf-8?B?UG84dWVBREhmU0dZMC9Cdk1kOFZxZU9zdjJNRlRzNkM2M0k0MG5iRTMxZDU0?=
 =?utf-8?B?blliZENjaS9mdEdFWUFlY1VaUHV4dGZOYVZwZ2NnYXdBa0RNaVlwQkNSSmZI?=
 =?utf-8?B?dzBYNU82TU15L1RFRFNMZno2eXQ5eTVlUXdlbXJaRXVtQmFtQTlLbEIxbVVB?=
 =?utf-8?B?V2ZCTm9nK1E2TndVaHphZlVPMUhuUWlONjRkQXVNSkF5aDR1QnUrZURIVEtX?=
 =?utf-8?B?UzBiQmttbnNIVjZzV29RYTY3MDNHRUtFaDlkK3crbGo5OVJ5TjNKMHBma2dw?=
 =?utf-8?B?VWpjVjFFSjRGSGxueWhMdHVTaDRzWVYxZWtnekpkMjRBaHBzV2FLVlRkTmNL?=
 =?utf-8?B?QVY2L0RuNXJieEp0b0tBSDdpYW5HYThLNHp0aWJ1RCtCTi85bzdheWc0Ti9m?=
 =?utf-8?B?bTNmekVtNmd6OFpkZ3Nwd2FTK3ZPTTZ2RnkrLzMraDFhbWx6UkJaOGY1OXV5?=
 =?utf-8?B?bmx5R1dtL2pWRVBDRVJCUFlGMDdRY1JWYVlkVExXcDRKZHRVYWZNU0VKM2ln?=
 =?utf-8?B?ZUdkQ3pmREwwRHJ6OHNPSEJKVUJzTXB6L050RzlMV2VoYkkzRDBQTUprSlpX?=
 =?utf-8?B?TGdBcFlxN1J4aTk0bms1dkVBemttZGZWZmV5QWVmeFl4QjNvRGFpTW9UVnho?=
 =?utf-8?B?MzEwWXBYUTlTUFVUTGE3L3hMUFVUT2Z5alZMTXZVSElvMEVTSHRGODdMNXBW?=
 =?utf-8?B?NUdsS3E5alZhUjU4SjZnRFR1Z0w1NitMZW82SytOVjVlSzJBZmtaRTVaaDhX?=
 =?utf-8?B?eituMVNCQW1tN1V0VW5McEJQTGpnWWdMdk90MzV1SFUxSlZuTkhqU3U5REpZ?=
 =?utf-8?B?TXFZY3ZlY1kwUHhHYk9vOU02QmFGYmxWekpPbUpFbEhqdE9ZQnFxSG5YWG5l?=
 =?utf-8?B?M3l6Ty9vUXlTNTJZd0lYaENSdTE5RXVQTytzK0V6bmovM0xjb25nQjhLK3h0?=
 =?utf-8?B?ZURoZUtMbmROa1NnYk9SM29aUjV4ZXM5aDlkRmd2MnErNDhHMVh3ZGoybjNx?=
 =?utf-8?B?TkhWUEVYTjlwNi81aVVYSjdKalVxWXdJcWh0U1g3eHJGejRSSFM0TFJBeVZi?=
 =?utf-8?B?L1FpczBUQzRnSlRZb2ZhYWhxbzExRmNPYmVRQnIyOWtxT1NVUkR4YmlxdFR2?=
 =?utf-8?B?TVpJVzJTTWM1dENBNUYrVFlJMndJRmRmRjN2ZDVmYWxVMHc4UmdpY0VBNU82?=
 =?utf-8?Q?WTg5Ls2AZJGmsTkVHYIs9AU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6F2A589DF42C7A438427AE7894A5CA82@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f49b9f44-5d88-4e61-dc95-08db0bc3c8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2023 00:06:11.8928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJKg5VkUFmUggFaBGgklu5KRpG0ZxIdbkZy2OAB6Y9tZXh9A0aPZRus1mSD99C39CYZ5+6zprlLAbHZY8bgtLFkHGKtZV6NJvr8vK8ZI7r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7267
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

T24gVGh1LCAyMDIzLTAyLTA5IGF0IDA4OjIyICswMTAwLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiBUaGlzIHNlcmllcyB0cmllcyB0byBmaXggdGhlIHJhdGhlciBzcGVjaWFsIGNhc2Ugb2YgUEFU
IGJlaW5nDQo+IGF2YWlsYWJsZQ0KPiB3aXRob3V0IGhhdmluZyBNVFJScyAoZWl0aGVyIGR1ZSB0
byBDT05GSUdfTVRSUiBiZWluZyBub3Qgc2V0LCBvcg0KPiBiZWNhdXNlIHRoZSBmZWF0dXJlIGhh
cyBiZWVuIGRpc2FibGVkIGUuZy4gYnkgYSBoeXBlcnZpc29yKS4NCg0KZGVidWdfdm1fcGd0YWJs
ZSBmYWlscyBpbiBhIEtWTSBndWVzdCB3aXRoIENPTkZJR19NVFJSPXkuIENPTkZJR19NVFJSPW4N
CnN1Y2NlZWRzLg0KDQpbICAgIDAuODMwMjgwXSBkZWJ1Z192bV9wZ3RhYmxlOiBbZGVidWdfdm1f
cGd0YWJsZSAgICAgICAgIF06DQpWYWxpZGF0aW5nIGFyY2hpdGVjdHVyZSBwYWdlIHRhYmxlIGhl
bHBlcnMNClsgICAgMC44MzE5MDZdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0t
LQ0KWyAgICAwLjgzMjcxMV0gV0FSTklORzogQ1BVOiAwIFBJRDogMSBhdCBtbS9kZWJ1Z192bV9w
Z3RhYmxlLmM6NDYxDQpkZWJ1Z192bV9wZ3RhYmxlKzB4YjlhLzB4ZTE2DQpbICAgIDAuODMzOTk4
XSBNb2R1bGVzIGxpbmtlZCBpbjoNClsgICAgMC44MzQ0NTBdIENQVTogMCBQSUQ6IDEgQ29tbTog
c3dhcHBlci8wIE5vdCB0YWludGVkIDYuMi4wLXJjNysNCiMyMzY2DQpbICAgIDAuODM1NDYyXSBS
SVA6IDAwMTA6ZGVidWdfdm1fcGd0YWJsZSsweGI5YS8weGUxNg0KWyAgICAwLjgzNjIxN10gQ29k
ZTogZTIgM2EgNzMgNGEgNDggYzcgMDAgMDAgMDAgMDAgMDAgNDggOGIgYjQgMjQgYTAgMDANCjAw
IDAwIDQ4IDhiIDU0IDI0IDYwIDQ4IDhiIDdjIDI0IDIwIDQ4IGM0DQpbICAgIDAuODM5MDY4XSBS
U1A6IDAwMDA6ZmZmZmM5MDAwMDAxM2RlMCBFRkxBR1M6IDAwMDEwMjQ2DQpbICAgIDAuODM5NzM1
XSBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiBmZmZmODg4MTAwMDQ4ODY4IFJDWDoNCmJmZmZm
ZmZmZmZmZmZmZjANClsgICAgMC44NDA2NDZdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAw
MDAwMDAwNDAwMDAwMDAgUkRJOg0KMDAwMDAwMDAwMDAwMDAwMA0KWyAgICAwLjg0MTY2MV0gUkJQ
OiBmZmZmODg4MTAwMDRkMTQwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6DQpmZmZmODg4MTAw
MjgwODgwDQpbICAgIDAuODQyNjI1XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDEgUjExOiAwMDAwMDAw
MDAwMDAwMDAxIFIxMjoNCmZmZmY4ODgxMDM4MTAyOTgNClsgICAgMC44NDM1NzRdIFIxMzogZmZm
Zjg4ODEwMDA0ODc4MCBSMTQ6IGZmZmZmZmZmODI4MmUwOTkgUjE1Og0KMDAwMDAwMDAwMDAwMDAw
MA0KWyAgICAwLjg0NDUyNF0gRlM6ICAwMDAwMDAwMDAwMDAwMDAwKDAwMDApIEdTOmZmZmY4ODgx
M2JjMDAwMDAoMDAwMCkNCmtubEdTOjAwMDAwMDAwMDAwMDAwMDANClsgICAgMC44NDU3MDZdIENT
OiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMNClsgICAgMC44
NDY0OTldIENSMjogZmZmZjg4ODEzZmZmZjAwMCBDUjM6IDAwMDAwMDAwMDIyMmQwMDEgQ1I0Og0K
MDAwMDAwMDAwMDM3MGVmMA0KWyAgICAwLjg0NzQ2NF0gRFIwOiAwMDAwMDAwMDAwMDAwMDAwIERS
MTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6DQowMDAwMDAwMDAwMDAwMDAwDQpbICAgIDAuODQ4NDMy
XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzoNCjAwMDAw
MDAwMDAwMDA0MDANClsgICAgMC44NDkzNzFdIENhbGwgVHJhY2U6DQpbICAgIDAuODQ5Njk5XSAg
PFRBU0s+DQpbICAgIDAuODQ5OTk3XSAgPyBkZXN0cm95X2FyZ3MrMHgxMzEvMHgxMzENClsgICAg
MC44NTA0ODddICBkb19vbmVfaW5pdGNhbGwrMHg2MS8weDI1MA0KWyAgICAwLjg1MDk4M10gID8g
cmRpbml0X3NldHVwKzB4MmMvMHgyYw0KWyAgICAwLjg1MTQ1MV0gIGtlcm5lbF9pbml0X2ZyZWVh
YmxlKzB4MThlLzB4MWQ4DQpbICAgIDAuODUyMDMzXSAgPyByZXN0X2luaXQrMHgxMzAvMHgxMzAN
ClsgICAgMC44NTI1MzNdICBrZXJuZWxfaW5pdCsweDE2LzB4MTIwDQpbICAgIDAuODUzMDM1XSAg
cmV0X2Zyb21fZm9yaysweDFmLzB4MzANClsgICAgMC44NTM1MDddICA8L1RBU0s+DQpbICAgIDAu
ODUzODAzXSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NClsgICAgMC44NTQ0
MjFdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQ0KWyAgICAwLjg1NTAyN10g
V0FSTklORzogQ1BVOiAwIFBJRDogMSBhdCBtbS9kZWJ1Z192bV9wZ3RhYmxlLmM6NDYyDQpkZWJ1
Z192bV9wZ3RhYmxlKzB4YmFhLzB4ZTE2DQpbICAgIDAuODU2MTE1XSBNb2R1bGVzIGxpbmtlZCBp
bjoNClsgICAgMC44NTY1MTddIENQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIFRhaW50ZWQ6
DQpHICAgICAgICBXICAgICAgICAgIDYuMi4wLXJjNysgIzIzNjYNClsgICAgMC44NTc1NjJdIFJJ
UDogMDAxMDpkZWJ1Z192bV9wZ3RhYmxlKzB4YmFhLzB4ZTE2DQpbICAgIDAuODU4MTg2XSBDb2Rl
OiAwMCAwMCAwMCA0OCA4YiA1NCAyNCA2MCA0OCA4YiA3YyAyNCAyMCA0OCBjMSBlNiAwYw0KZTgg
NzkgMTggN2YgZmUgODUgYzAgNzUgMDIgMGYgMGIgNDggOGIgN2INClsgICAgMC44NjA3NzhdIFJT
UDogMDAwMDpmZmZmYzkwMDAwMDEzZGUwIEVGTEFHUzogMDAwMTAyNDYNClsgICAgMC44NjE1MTld
IFJBWDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmY4ODgxMDAwNDg4NjggUkNYOg0KYmZmZmZm
ZmZmZmZmZmZmMA0KWyAgICAwLjg2MjUzMF0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAw
MDAwMDA0MDAwMDAwMCBSREk6DQpmZmZmODg4MTAzODBlN2Y4DQpbICAgIDAuODYzNTIyXSBSQlA6
IGZmZmY4ODgxMDAwNGQxNDAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOToNCmZmZmY4ODgxMDAy
ODA4ODANClsgICAgMC44NjQ0NDldIFIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IDAwMDAwMDAw
MDAwMDAwMDEgUjEyOg0KZmZmZjg4ODEwMzgxMDI5OA0KWyAgICAwLjg2NTQ1NF0gUjEzOiBmZmZm
ODg4MTAwMDQ4NzgwIFIxNDogZmZmZmZmZmY4MjgyZTA5OSBSMTU6DQowMDAwMDAwMDAwMDAwMDAw
DQpbICAgIDAuODY2NDAxXSBGUzogIDAwMDAwMDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODEz
YmMwMDAwMCgwMDAwKQ0Ka25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KWyAgICAwLjg2NzQzOF0gQ1M6
ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KWyAgICAwLjg2
ODE4MV0gQ1IyOiBmZmZmODg4MTNmZmZmMDAwIENSMzogMDAwMDAwMDAwMjIyZDAwMSBDUjQ6DQow
MDAwMDAwMDAwMzcwZWYwDQpbICAgIDAuODY5MDk3XSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIx
OiAwMDAwMDAwMDAwMDAwMDAwIERSMjoNCjAwMDAwMDAwMDAwMDAwMDANClsgICAgMC44NzAwMjZd
IERSMzogMDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3Og0KMDAwMDAw
MDAwMDAwMDQwMA0KWyAgICAwLjg3MDk0M10gQ2FsbCBUcmFjZToNClsgICAgMC44NzEyNTldICA8
VEFTSz4NClsgICAgMC44NzE1MzddICA/IGRlc3Ryb3lfYXJncysweDEzMS8weDEzMQ0KWyAgICAw
Ljg3MjAzMF0gIGRvX29uZV9pbml0Y2FsbCsweDYxLzB4MjUwDQpbICAgIDAuODcyNTIxXSAgPyBy
ZGluaXRfc2V0dXArMHgyYy8weDJjDQpbICAgIDAuODczMDA1XSAga2VybmVsX2luaXRfZnJlZWFi
bGUrMHgxOGUvMHgxZDgNClsgICAgMC44NzM2MDddICA/IHJlc3RfaW5pdCsweDEzMC8weDEzMA0K
WyAgICAwLjg3NDExNl0gIGtlcm5lbF9pbml0KzB4MTYvMHgxMjANClsgICAgMC44NzQ2MThdICBy
ZXRfZnJvbV9mb3JrKzB4MWYvMHgzMA0KWyAgICAwLjg3NTEyM10gIDwvVEFTSz4NClsgICAgMC44
NzU0MTFdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0K
