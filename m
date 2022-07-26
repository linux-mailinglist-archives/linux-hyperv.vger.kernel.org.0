Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AD6580A05
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Jul 2022 05:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbiGZDeW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Jul 2022 23:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiGZDeV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Jul 2022 23:34:21 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021021.outbound.protection.outlook.com [52.101.62.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F087C28E33;
        Mon, 25 Jul 2022 20:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7IFckYnDeLz/NHH8aV5TAqvf+QtOSuxw77DL3/C9D8xNX4K3TT0crqzdXycC2DlaaPQwqIx9xBacedU7Mhk6+BPCnZYuOOgKdUD0B7p4BEj9zr7eIcWdIlS4zF2aNdr+7V/7jYIJDJwr+8Gc3WETaFFGXrl8/AYFNWam+ZxFpHy+mwIo87cySswL2S3UxhWaO2NMvKKLRH9g2kN0SXTLoRdl8WBGm86Ok8tuig/Ia7O5FtGYuy41DSSzB/lrtw7zAFYjXnyI+xTOat16UATfJEYgwfldNR6hnaoAVPfgU3mpMsW/jbEZAVJcOJrJi8q0wUKwIjPLItDHkbb9wkY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5QW3EN6nNnoWHZugZqGLlS0BRuyAoAIMHRIRFqYwVo=;
 b=R4tm5ET4tgVSe5nstjQ7VwlbK9Cui1YuE4mP8wMiKGJ4EZjdd7WWetLQGEISRGxyDruj1mQRlPhxC9/cI73NHjEf7hQVI8cO9UKrRHhi/9kWNypxeAFSgzHe6e0SBsHUukvfeQKVtdSVY+TLSordPV2IGxoaIk7jbvTciZXS5zW+zbbznRJU63SFiTuUd7J5SKvVGNDMkCBuCtyuXFBPtRFBWz3Dbo9CN5talGU1mrNNrbK7Bm7xkKBnl7F5VUT4Va52mNcMO+b5pNABiVPQmuVbUfn593FluMF4aTZqWXOQMtgtvDWW8Dm03pm/+7Za1txWZP0tBf3E2mQPwt/Mhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5QW3EN6nNnoWHZugZqGLlS0BRuyAoAIMHRIRFqYwVo=;
 b=ee35oYsUUUlwoNB89/80foKUzEtCMA+kBAnPVPZ8BLfU9NHNwb193aOBtjbWdUR/nRwD/Q6xsv/X9J4bMQkqdKulsbaE/2b8JHvFMUaoX8aXfHiVZYYnMIPCglu0UNGMjfLX8p/AvzAh6Kwg5KW+fGw8TNWlJkxW2pfyytYl7B0=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DS7PR21MB3366.namprd21.prod.outlook.com (2603:10b6:8:82::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.1; Tue, 26 Jul 2022 03:34:17 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::ddda:3701:dfb8:6743%4]) with mapi id 15.20.5504.001; Tue, 26 Jul 2022
 03:34:17 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "samuel@sholland.org" <samuel@sholland.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Thread-Topic: [PATCH 1/1] iommu/hyper-v: Use helper instead of directly
 accessing affinity
Thread-Index: AQHYoIotS/wddpzfUkKuAt8ax//n6a2P8LwAgAAMsPA=
Date:   Tue, 26 Jul 2022 03:34:16 +0000
Message-ID: <PH0PR21MB30257943986E96BAF8F925ADD7949@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1658796820-2261-1-git-send-email-mikelley@microsoft.com>
 <5ea65d3d-745e-0a16-c885-a224a20ee7ce@infradead.org>
In-Reply-To: <5ea65d3d-745e-0a16-c885-a224a20ee7ce@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=49758721-c229-423b-a364-71f147ee7fbc;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-07-26T03:24:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9010db87-41ef-48c7-4094-08da6eb7b7e1
x-ms-traffictypediagnostic: DS7PR21MB3366:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bXa1WYspzyRkoJiUmJaxSem4nmriunbVJiTy+IHjh2Rdo50AiCvXMwl5ftD8shvn0Mtnucxhm7fkwZyyayyQz/E2FRFaFACEbVVCkC11DYFPgxNLyqLTBl0ldvPits4yJiPVQ3iXt8Mmac9HNhR20BRTU8cXgRopAicE7m/p3gB/ruZwlbGm1ykaH2pZVuDQARqgg8VyTs2LeHyUi6DRA4Bo+hfCN06ebjsNSlnhJKC8DTQhG5nPoBVA3RlGK6RptXKGOTRVLLZgY0Nf8yWJhJfW1sA//O36nht1PwTfVbqOfjt13JKEI1bkxAyk4JGTGImYubPMQKp/SURTsswI0l/wNQOIJK7kKCWJpW5J4FWKYnpb9H74D/CsPhYQ2SiSaHn4MsUsrgYAAMFXteclPEy+Vh0VjSVjhETrkJ2aFEYJOwAuaEVkNCo7SGK4rQ9/qDy31etKogP8nalevw9KZWtgQD63heRolXq0aW0y+8Ftc8dF9Fi6tM9Z6skPYEfRLG9rjw245SvUCjrtvABwmKVLpm8B7PMTj03q86mnOpwKu/o31vzrH9nQNmBsdJH5u/F3H2X3n3ptAMwgvtwpdmc2nEMyRJxLgWIKMY7OgQiJjWyuhJ9dYvuYVIo4jDe/FV9Cr7u0/h+TaVmBFLggditcC1fRfZ0lZXtiXyrXrYvWx7iNtTSyhZyv8nhyFMds1kcdBlpT4JnrcgRFb5bX/4yTTgwk3tDlMirhEjr7/391L4mxkDhYvZtDxFmWAsNuF1Rr75adA/tCVJ8SfUQ507Xw80Lzsdud6eBtW7rkfBLcbS+6cSHv27E5D+NDXh1o730Muj5X8PcVGV4p3Qhb+rPXyzTf6vqLRir0SVHDxX7R6SColVZeour5Txhbzt/y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199009)(52536014)(478600001)(66476007)(55016003)(5660300002)(71200400001)(64756008)(33656002)(8676002)(66446008)(7416002)(6506007)(66556008)(66946007)(7696005)(8936002)(9686003)(83380400001)(76116006)(8990500004)(86362001)(53546011)(26005)(38070700005)(2906002)(110136005)(186003)(82950400001)(41300700001)(122000001)(38100700002)(10290500003)(921005)(82960400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWdQL0RCWWRjU25oMEZ0UHZyRm9LOFN4ZmEyQjQvdlJHS2tlMW1wRWlxMEVB?=
 =?utf-8?B?cWxadnc0a2VzUmJnYloxK3VxSEFNWEo3ak1iQjBVUlg0R3JGVzRJMlkwYkhp?=
 =?utf-8?B?dklLU2hWZHRPTk1TVWs4RjlQeWpsREZqNnV0VWZFSVVCMHhoOXdCeUxweFd5?=
 =?utf-8?B?UGRGWUQvRElSQ0VWQkVkNGVRWDFRSzB4eERINkV2aTUyRDlLdU1Pa0JnbzMy?=
 =?utf-8?B?clp1azV5NjZJQW52K3NsczZlWi9DQUt4UGljd1dlWXlQVi9PY0NCRmlBS05x?=
 =?utf-8?B?VVBPUENKY25rZEVsUHlnaHVzcXZ6aHdNR2ovSVRzS0gvRnBYUy9maHVjSE9P?=
 =?utf-8?B?bmp0T25pRnJKOGNLaFU2MkJBUjdxRVhTalRtbWtuOHBJS3ZQZlpGcng0eS9Z?=
 =?utf-8?B?ZFJHNHg3SHdDNVJWUjlWOWdZRjJVQ1MvRXFGTUt3MmRncnNodUQ3ZUFjc0tw?=
 =?utf-8?B?dDZoQ1B6WWVhZjZiRnhQdXNOOElvZXNkdC9PZ2lzVy9LQUprNmxsOEd4ZmFX?=
 =?utf-8?B?QVk1TXl6YzVqdlZTYmdBZ1h0RFpsMmVvekIvcUFFRTdjeGUyei9WWVBURlFE?=
 =?utf-8?B?bmRXam5nNkxvbTBidDBLZlFQd2JjMEVHNXhlWHdIOEllZFJpbzRlU0NPbisz?=
 =?utf-8?B?akNlTmczNlpsdEZiUXJNYTc4cU43YVN4bm5iQkFTbUZuZDVueEdpVHFzMndM?=
 =?utf-8?B?YTZQaGt1MEpUMXpPQUVqWEgrM0NNaHdUUzl0MFVGYkNKQ1hvMXg3cjJOT0Jz?=
 =?utf-8?B?SXlySUVMUWlPUm5kMzhUTFhQSXpnZHdrQUlQdy9mQ1FXQ2RXVE1NeHhXV25Q?=
 =?utf-8?B?OGErQ2V2Wmg5TnZtd2toMVN4RFVvVEhHdkFGTDR6aW9YN1N5UWhaYnJ1dmUv?=
 =?utf-8?B?VEF6M0R4akxreDE5L0NMWnJmcDRTTm1TLzFWcVNlMkxFZnlXVDVCSm1hMlhS?=
 =?utf-8?B?RmdHNjBMLzE5dmM4bEhxYnJEOHF6Y1pIbmFuVG5LQ2NGYjMyd1dUWmtVQmpG?=
 =?utf-8?B?MVJ2VDRhZFlCeHJReFZ3US9qc3RnczRrT1c1Ykl6U1BMRlZyMXBMbkszWmZY?=
 =?utf-8?B?d0hTN21mcmZ6Nk0yZFZhcjFyWWYrUk0rc2FLS1d3aEtLZDdBSzZHVXVuc1N3?=
 =?utf-8?B?RFFCMXRUS29lbjRqK3pPc1lhRW9VSjRtZCtWZHgrQlE0b2ZQQmVwYktJTnNz?=
 =?utf-8?B?M1NYWVJVT29ocXRUQmJLbGd1REpvanNjU2RXTVFGVHBIOHRmQ0R4ckxVSTdi?=
 =?utf-8?B?Wnk0bHh1cHBiUDYrUDI3UWpNL3NRQ2JDbkRjQ01QZ2NVM25EOHdnVVB4ZWph?=
 =?utf-8?B?aFZkdnNTaU43RUFlbEJOck05alRJTksyNk0rbjNLalU4bEZnSFFHekxaaU1R?=
 =?utf-8?B?QkRHZlU3RTdNR29KM0RRdzRjSHloeDRBZ1JLMGRkZnZkSFBCSURpeTE3ZVpl?=
 =?utf-8?B?T05GUmFzYStDbmkzbm5BRmdiYkdTWXg0ZjdKMkJlWGxXam0zSkNqc2xIUk1L?=
 =?utf-8?B?eHZlWjhpUlpDU3BtVjlvaExSeEZKTTRtaTNybFBpRnBPMXRHRFNyckc3aGtB?=
 =?utf-8?B?c2x2SEs3YWFkNVorK3RPa0gyOUZsdEhKcFVtU3EvZXI3aFBkbjFDODYwTWo4?=
 =?utf-8?B?eld4UGVNbUo4S0pFUUswc2JmTzArTkwvTzB4c2FCSkNJaVV0OUpTbkZJQTRs?=
 =?utf-8?B?bFdOQ0xvL0Y4T0hZV21VOUtDSmQ3YnlLRGRGRklaTnZDMWpxZ09QbzZFVWs2?=
 =?utf-8?B?cWJLMzNwc0xLSW8yUlc1WG52VEhNSDFQTlgzaUZuNHBGYVBENTRQeXBUVDhp?=
 =?utf-8?B?bW41ZElVS2gweXVwc2FJRUxSYVZwanYwRXRrVlp4alo3cDhYWFRBQUFnaDBF?=
 =?utf-8?B?UGR4OUgyaEI5SEtTMEZlN2JlbXY4WGlJZlY1VlRYYnlWNUhudDJFc0FLRjRN?=
 =?utf-8?B?cFZRUS8xNnZkeE5VT0ozZzNlZWJ6YzNXSDIvN2trQjFhdVhSN3NadW02U0lr?=
 =?utf-8?B?K3hGakljOTVma054TC9KV2RTVkNTY0VxVU91SkVCclZyejRva21zYVdiT0t2?=
 =?utf-8?B?aTRzcWlJbmx0dEs4dlZIdEhDbmhVT2RxVFpoKzEzSEsxejMwVEdkUG5NMENj?=
 =?utf-8?B?RVE2OFpHRHFIdE9xanhaLy9YZkhNTEJOL2FPS203Si9tcjhRNWgzbzQrRTk3?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9010db87-41ef-48c7-4094-08da6eb7b7e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 03:34:16.8784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wDv206Oxq1Ci21WRD0GkFIF5HmvF/1X/lnirbOepS/TlHO9TV3xId8J+V8cbMnmsOAD2TSAlEOD6dTrl1wIYiA+5VhBbfM1GXh8odYm/TL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3366
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+IFNlbnQ6IE1vbmRheSwg
SnVseSAyNSwgMjAyMiA3OjM5IFBNDQo+IA0KPiBPbiA3LzI1LzIyIDE3OjUzLCBNaWNoYWVsIEtl
bGxleSB3cm90ZToNCj4gPiBSZWNlbnQgY2hhbmdlcyB0byBzb2x2ZSBpbmNvbnNpc3RlbmNpZXMg
aW4gaGFuZGxpbmcgSVJRIG1hc2tzICNpZmRlZg0KPiA+IG91dCB0aGUgYWZmaW5pdHkgZmllbGQg
aW4gaXJxX2NvbW1vbl9kYXRhIGZvciBub24tU01QIGNvbmZpZ3VyYXRpb25zLg0KPiA+IFRoZSBj
dXJyZW50IGNvZGUgaW4gaHlwZXJ2X2lycV9yZW1hcHBpbmdfYWxsb2MoKSBnZXRzIGEgY29tcGls
ZXIgZXJyb3INCj4gPiBpbiB0aGF0IGNhc2UuDQo+ID4NCj4gPiBGaXggdGhpcyBieSB1c2luZyB0
aGUgbmV3IGlycV9kYXRhX3VwZGF0ZV9hZmZpbml0eSgpIGhlbHBlciwgd2hpY2gNCj4gPiBoYW5k
bGVzIHRoZSBub24tU01QIGNhc2UgY29ycmVjdGx5Lg0KPiA+DQo+IA0KPiBSZXBvcnRlZC1ieTog
UmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQoNCkluZGVlZC4gIEFwb2xvZ2ll
cyBmb3Igb21pdHRpbmcgdGhpcyBvcmlnaW5hbGx5Lg0KDQo+ID4gU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBLZWxsZXkgPG1pa2VsbGV5QG1pY3Jvc29mdC5jb20+DQo+IFRlc3RlZC1ieTogUmFuZHkg
RHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IEFja2VkLWJ5OiBSYW5keSBEdW5sYXAg
PHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gDQo+IFRoYW5rcy4NCg0KVGhpcyBwYXRjaCBuZWVk
cyB0byBnbyB0aHJvdWdoIHRoZSBzYW1lIHRyZWUgYXMgU2FtdWVsIEhvbGxhbmQncyBlYXJsaWVy
DQpwYXRjaCBzZXQgdG8gc29sdmUgaW5jb25zaXN0ZW5jaWVzIGluIGhhbmRsaW5nIElSUSBtYXNr
cyBvbiBTTVAgYW5kDQpub24tU01QIGNvbmZpZ3MuICAgRnJvbSB3aGF0IEkgY2FuIHRlbGwsIHRo
YXQncyB0aGUgaXJxL2lycWNoaXAtbmV4dCB0cmVlLg0KDQpGV0lXLCBpdCBhcHBlYXJzIHRoZXJl
J3MgYW5vdGhlciBvY2N1cnJlbmNlIG9mIHRoaXMgc2FtZSBraW5kIG9mDQpwcm9ibGVtIGluIGFy
Y2gvbWlwcy9zZ2ktaXAyNy9pcDI3LWlycS5jIHdoZXJlIHRoZSAiYWZmaW5pdHkiIGZpZWxkDQpp
cyByZWZlcmVuY2VkIHdpdGhvdXQgYW4gI2lmZGVmIENPTkZJR19TTVAuICAgQ29weWluZyB0aGUg
TUlQUyBtYWludGFpbmVyDQphbmQgbWFpbGluZyBsaXN0IC0tIHRoaXMgb25lIGlzIG91dCBvZiBt
eSBzY29wZSB0byBmaXguDQoNCk1pY2hhZWwNCg0KPiANCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9p
b21tdS9oeXBlcnYtaW9tbXUuYyB8IDQgKy0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9oeXBlcnYtaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvaHlwZXJ2LWlvbW11LmMNCj4gPiBp
bmRleCA1MWJkNjZhLi5lMTkwYmI4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaHlw
ZXJ2LWlvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2h5cGVydi1pb21tdS5jDQo+ID4g
QEAgLTY4LDcgKzY4LDYgQEAgc3RhdGljIGludCBoeXBlcnZfaXJxX3JlbWFwcGluZ19hbGxvYyhz
dHJ1Y3QgaXJxX2RvbWFpbg0KPiAqZG9tYWluLA0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgaXJxX2Fs
bG9jX2luZm8gKmluZm8gPSBhcmc7DQo+ID4gIAlzdHJ1Y3QgaXJxX2RhdGEgKmlycV9kYXRhOw0K
PiA+IC0Jc3RydWN0IGlycV9kZXNjICpkZXNjOw0KPiA+ICAJaW50IHJldCA9IDA7DQo+ID4NCj4g
PiAgCWlmICghaW5mbyB8fCBpbmZvLT50eXBlICE9IFg4Nl9JUlFfQUxMT0NfVFlQRV9JT0FQSUMg
fHwgbnJfaXJxcyA+IDEpDQo+ID4gQEAgLTkwLDggKzg5LDcgQEAgc3RhdGljIGludCBoeXBlcnZf
aXJxX3JlbWFwcGluZ19hbGxvYyhzdHJ1Y3QgaXJxX2RvbWFpbg0KPiAqZG9tYWluLA0KPiA+ICAJ
ICogSHlwdmVyLVYgSU8gQVBJQyBpcnEgYWZmaW5pdHkgc2hvdWxkIGJlIGluIHRoZSBzY29wZSBv
Zg0KPiA+ICAJICogaW9hcGljX21heF9jcHVtYXNrIGJlY2F1c2Ugbm8gaXJxIHJlbWFwcGluZyBz
dXBwb3J0Lg0KPiA+ICAJICovDQo+ID4gLQlkZXNjID0gaXJxX2RhdGFfdG9fZGVzYyhpcnFfZGF0
YSk7DQo+ID4gLQljcHVtYXNrX2NvcHkoZGVzYy0+aXJxX2NvbW1vbl9kYXRhLmFmZmluaXR5LCAm
aW9hcGljX21heF9jcHVtYXNrKTsNCj4gPiArCWlycV9kYXRhX3VwZGF0ZV9hZmZpbml0eShpcnFf
ZGF0YSwgJmlvYXBpY19tYXhfY3B1bWFzayk7DQo+ID4NCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9
DQo+IA0KPiAtLQ0KPiB+UmFuZHkNCg==
