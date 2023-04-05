Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125F26D7407
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Apr 2023 08:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236893AbjDEGAU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Apr 2023 02:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236791AbjDEGAT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Apr 2023 02:00:19 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6ED273D;
        Tue,  4 Apr 2023 23:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R8XzHsXHPyAuOHXPpYfFGBtDfZN04JJRojKdm1Bwu5+kumJY4FcH61R5O3Vd3RWLtxXC6bURSbQGyRuVaGRZVhoDeilVsHu/yjePS2gT+J1BK3b9l3DWWNUADIFaIOT7dblAFYAURGWPLA2WrlgFuhlpWglsA1/4KHJFAmkEAuSGU6mpbpN9uXpyo1qr/9IkSYdxFp4C6Fyfhu6/Mt1vgFOMbqy49UXk0W2Y9nednwd6OJ2pDPujhB/NpukVpzwfnYhiT+ohjCHaXwnGgRaNPdI4lGcFDWFESyffwyLYmQYBW2aicA3wKijZRpnZaEPQzD5tSAqYSOuzEV0WXxeTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Odg8D0FA3u0rFGKN9cll1m0MT0luYR8jLdDeRahwNXY=;
 b=SxJ553zc06NI0J/Fri8Cmm9T/mhhLgT+5yrEeuWGx7QexUNWbXfrbEd6ypj5n5KAj8uejIqOQMhVi7/zggcpu1e4Wm0Azr6ecugcMs3vIFBE7+X+YVmy/k/p2B0Zwakfs1+2PYqhtqT/pYXxqznPQoWwG5tmEqMiD9qvZaWcv5etyeOdQFW50xWs/xEdPtT2wpQQdnRPMO8uF/iqn7HC6af1gul1Pn/ay0QKpG6eJmtNWOR5oyYN1Lt1LyEegxX1I7yybqncoa4ap1RyH2g9Jg+70Lbj5/otaxq5TXGTEq1qQEa+3AUkc/3MBaPcuffBAf4HlMMSdvzy48isdV8Q1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Odg8D0FA3u0rFGKN9cll1m0MT0luYR8jLdDeRahwNXY=;
 b=GgdJ7xtV8cXP1+TLTLFFYmIOyCsbh1B6XZz/jwD6RaXQ3Fp4bwQkj7lszMm63+s3Q223ivyUF1FbNQFseURICTU4KBcStOQaD72fTAo3/ds2aTUVlRhusPJSgOLeugLGCusxly7ZGym2YGGLTSXa6V+qILZbV6sb39mygSav5Rs=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM4PR21MB3345.namprd21.prod.outlook.com (2603:10b6:8:6b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.8; Wed, 5 Apr
 2023 06:00:13 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::2e52:d6aa:9a99:500a%5]) with mapi id 15.20.6298.014; Wed, 5 Apr 2023
 06:00:13 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC:     Dexuan-Linux Cui <dexuan.linux@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Jianxiong Gao <jxgao@google.com>,
        David Stevens <stevensd@chromium.org>,
        Joerg Roedel <jroedel@suse.de>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Thread-Topic: [PATCH v1 2/2] swiotlb: Fix slot alignment checks
Thread-Index: AQHZZy9yhTeXGQzb+UuJvAtlASQcDK8blAYAgACPDoCAAAMzcIAAEHvIgAACA6A=
Date:   Wed, 5 Apr 2023 06:00:13 +0000
Message-ID: <SA1PR21MB1335CF4B7E9B1EC61B84AA03BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <cover.1679382779.git.petr.tesarik.ext@huawei.com>
        <c90887e4d75344abe219cc5e12f7c6dab980cfce.1679382779.git.petr.tesarik.ext@huawei.com>
        <CAA42JLa1y9jJ7BgQvXeUYQh-K2mDNHd2BYZ4iZUz33r5zY7oAQ@mail.gmail.com>
        <CO1PR21MB13320305E02BA121623213DABF939@CO1PR21MB1332.namprd21.prod.outlook.com>
        <20230405064019.6258ebb3@meshulam.tesarici.cz>
        <SA1PR21MB1335C5F774195F2C3431BF93BF909@SA1PR21MB1335.namprd21.prod.outlook.com>
        <20230405072801.05bb94ef@meshulam.tesarici.cz>
 <20230405075034.3c36bb77@meshulam.tesarici.cz>
In-Reply-To: <20230405075034.3c36bb77@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1f966a54-fa98-4a7e-a454-6e469b8292f5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-05T05:57:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM4PR21MB3345:EE_
x-ms-office365-filtering-correlation-id: 11f997b8-e765-42f7-98d0-08db359b0594
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cewZ5O1gk9z954xcXfvPbGC9VbQJFJJepUxUCpaRoGE4ilGf0PP3tVd+tN6C+QvQw88V00w1YDl4eRtfbGMuzokkBk6K/m4O1AMaLns4ed9/3fDvQgnQl/bSBWzkgApfDjVT0woMbIezVxvEaxoYnKuSvp3VoneBPkLmW8ZWR0ZrVkumI0Ddl6V4wah9uZsHKzzXalkqjuCd0cTAMxfGoBZJsTli5FVJJISLrTBz2LaKruUCmR4ujoyHwUJUoM988d69uN3YxYZeMpMVJ9+MxHa3edcXedA6W+GreIPi6CSvd/FT3bXOCnZhjQy9+GcwfxdZ+Oq4MF4yxR6z8fREt0yUUPe00MZQXmUu/DVdQjnvnWDXHhO2QRxXKZ8NPa5dPY9pLSkRaNMhQIjJB9q/kXN/Kvap+wR3cc6r7FOMNiO2ssTRgHgZnbfk8cTqpXkcv//1ZI1MCt9G0vCjNyHmsVTctH894PHHcqBez3H0nHY5aXcTn99GfrLsIghOfJJhQi6pIdS2D/iAT3jQvW98HliWe6FDzdWhZ+TLxVh0+a2E3rda0t8S8V8zbsKShhtWN6x+I2pabHF1cNSjubAGJyZRuui5MbCPphINliy8+nGOG1itDGKGooAJFSEtCDY4yhLG1+fY0vflvlh3v1gZS6vvgdqeUEVTQ8gV6ksExM4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:cs;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(26005)(478600001)(10290500003)(2906002)(186003)(9686003)(6506007)(8990500004)(55016003)(71200400001)(33656002)(7696005)(122000001)(52536014)(82960400001)(6916009)(38100700002)(4744005)(82950400001)(86362001)(5660300002)(316002)(786003)(7416002)(41300700001)(38070700005)(4326008)(8936002)(64756008)(76116006)(66476007)(66446008)(66556008)(54906003)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2VxYTBwYkRmaTgySFdMdFVxTlJmU2t4dzA0YVlWVHg2MFRndlJNVmYwWjFX?=
 =?utf-8?B?YWRVeFFlQmRRTlUzRVpmMks3NUw2UUwza1I0d05iTkp5UmdFUUQ5dVBESjEy?=
 =?utf-8?B?aUFHMEU4SUxtSUtnOVdkTFN2eDE0aFROWnRXT1RQZkM4bG9yN3FHSFk5UmFK?=
 =?utf-8?B?ODJWK3daVE5QUWQxUjRZSFdYeEZMNkF0eGFLYUxyMHVxMEo4anpLa0NMYTVj?=
 =?utf-8?B?Yk8rUk5oYjZuY1FQL0NPZ2lxdWJjaGtrR01yMVRVaWQxYTYxMUdHTkNibHE0?=
 =?utf-8?B?aWJnYzVpTDJ0MElKUU1GRTJDWGZEaXdoRjhSL1pWelc1dzZuRHo4MGlXNFZ2?=
 =?utf-8?B?WGw1MEl3Q2F5VzlHYnJQeVhURTMxcVpKVUpMSFV4K0tqVjJUd0Y0V0NSYnN6?=
 =?utf-8?B?bXJjRk4rdStOazVyMXJVUWRyWDFOalowZUgrT0N6VnVBK0x2RVovNHB5alht?=
 =?utf-8?B?dktrcCs2NlQrdHV1aEp3cllMQVJsYjdFakRYSXUvWUltclJ3SWJIcy9GcGdY?=
 =?utf-8?B?OGdWRFZndGFrTE8xRVh3ZVNaUm4rRHpGYTBxUzN0UlRMVmNFV0k0aDVSTGxi?=
 =?utf-8?B?MnlLRzJNTUdiTDZxcFF3cjQ0SWtSOStOYzdtTk90WG56dldRR0RSYklKWktB?=
 =?utf-8?B?NzUxSWJ5cG9JN0FlNUVIUE91RnhlYnU0WW5HN1doZmJwOTVDam16cFlSSFRF?=
 =?utf-8?B?U3BZd0VwK1oxZjU2dERoNXN2MTZXYWZLYWRCb25jV3B2ZUhWL3FLNTR3ck1P?=
 =?utf-8?B?akxOem16ZFgyZkNpeFAxRDlOZWtoN2hZcExJVzJsU0dwelVKMm1Ba1VoRGJX?=
 =?utf-8?B?akVIOEVvbTFRVkp3eGkvV0QzblQ5aTZMb0tlVytCRnN5dXBQSXErVHd6ajZG?=
 =?utf-8?B?S0FBK0Q5VEJydlB6c2k0T0VuSTd0TDBCT2VVMEZrK2QzSUV5T2Y4OUlTOGpY?=
 =?utf-8?B?cnZNb0dpRUdHNEtIaTVMRHZSV2JuN0RyWXZtUExVKzhDM1RlM2IrUkpSQ2dl?=
 =?utf-8?B?ZzlCTzVVQlFzZkRKV05wMEk2MlR4RnE1NGNkaWZMYU1BN0Erb0NuRytoTzJO?=
 =?utf-8?B?b24zeUdOejZBTmo5Y1VISTlNVmV6NytBYnJIQ1dvL0lTSmdsRWlhUHZhUUxx?=
 =?utf-8?B?Nk85Wm9FODVFcWRyKzEwcHRrNTJCaElRMTRrZGxmUFBCR0pNUTMyL1NKdkNs?=
 =?utf-8?B?dGEyMkJ1SXkrYWlNeEQ3Nkk2bG5VTUdnMWlTbzJ6UWFXMkduNm45ODBzUG0z?=
 =?utf-8?B?bU1DRDNZVHlEbGQwbmZhbjJvZXEyQjc0Vzd0SlF0ZDU4WldsZTBCZzNiSFZQ?=
 =?utf-8?B?VHlhMnVXOE9PVUZmZEVvbEV3RUxhNEJHOERwZnZDY1dRZEdGMlRBcFFjVzRj?=
 =?utf-8?B?c0xuUnBYNE9MOUViSkozSnpHOEFXQlViRWg5cTJLbFc0SmFiTmFWL2JLRGhJ?=
 =?utf-8?B?b2xvZEp2c1c1RGYzVUUzdWNmSUcrb0U0QTNOYmxMZjNDVHdyRENPbzRMbG1Q?=
 =?utf-8?B?MUwxQjBRZGlZQy9ZN0JhY1N5MHp3ZmNJSzNrN0ttWUpzYjB5RVhFa3c1RnQx?=
 =?utf-8?B?RGh3aXdlZW1oakpDUXZNUlU5cFUyWmowdjVZZlJaRUdDQmg0b0VtekV0ZlAr?=
 =?utf-8?B?KzRsSWU1NHR2NUJnVExQNU9DWEoycmI5N2pLWGNWR0hoYlNCdnhxR1VMOUFw?=
 =?utf-8?B?cHdqbnBqVlZKUGV3VDRueXFqdlArbHFyNmxHWW95Z1NOcUZtUnYrclh5ZTVq?=
 =?utf-8?B?U0FmRThHWFB0Ty80aU1KcEc1a1VOVnBuRWlPczVmWSsvU2VwZWVkRDVwR1Mz?=
 =?utf-8?B?eHZnSEJqL2NwdUwxZmRYNGNEdnd6S3VXYldvSXZybEdPQWF5eTI2YS9qYXRv?=
 =?utf-8?B?RWQ3dnFVbWs2bnNuSXduc2FQSis1UW52ZDhZUkt6cCtMZ0hUM0NMVms5cDRr?=
 =?utf-8?B?WkhybkxuQlZMSzdHOHpSb0d6TzZMNWZPTFNjNFFpazFMM3FpSlZ0U2R2WVlp?=
 =?utf-8?B?aWwyR3RTRlh5WENxM3ZjTFZ4WXVvdlFnMVhHRGtRMExWWU5XZjBkcVcxVlFx?=
 =?utf-8?B?bFdqTXdnODNnSFZyektOY2dWTmFZVGtYN3pEMFUxVUlib05aMXVZQ1Z6MWJO?=
 =?utf-8?Q?OH0osHDN63D9acFadQVpmdYsT?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f997b8-e765-42f7-98d0-08db359b0594
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 06:00:13.2456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p33rFusqlY46GxOL0eunO3uliJuN2Ev1o4JVwbPgb0XC9CNIR8ykwMlXq340LN/hJboRFeHD/+xn8gIAFSpX4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3345
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBQZXRyIFRlc2HFmcOtayA8cGV0ckB0ZXNhcmljaS5jej4NCj4gU2VudDogVHVlc2Rh
eSwgQXByaWwgNCwgMjAyMyAxMDo1MSBQTQ0KPiA+IC4uLg0KPiA+IEFyZ2gsIHlvdSdyZSByaWdo
dC4gVGhpcyBpcyBhIGJyYWluby4gVGhlIGFsaWdubWVudCBtYXNrIGlzIGluIGZhY3QgYW4NCj4g
PiBJTlZFUlRFRCBtYXNrLCBpLmUuIGl0IG1hc2tzIG9mZiBiaXRzIHRoYXQgYXJlIG5vdCByZWxl
dmFudCBmb3IgdGhlDQo+ID4gYWxpZ25tZW50LiBUaGUgbW9yZSBzdHJpY3QgYWxpZ25tZW50IG5l
ZWRlZCB0aGUgbW9yZSBiaXRzIG11c3QgYmUgc2V0LA0KPiA+IHNvIHRoZSBpbmRpdmlkdWFsIGFs
aWdubWVudCBjb25zdHJhaW50cyBtdXN0IGJlIGNvbWJpbmVkIHdpdGggYW4gT1INCj4gPiBpbnN0
ZWFkIG9mIGFuIEFORC4NCj4gPg0KPiA+IENhbiB5b3UgYXBwbHkgdGhlIGZvbGxvd2luZyBjaGFu
Z2UgYW5kIGNoZWNrIGlmIGl0IGZpeGVzIHRoZSBpc3N1ZT8NCj4gDQo+IEFjdHVhbGx5LCB0aGlz
IHdpbGwgbm90IHdvcmsgZWl0aGVyLiBUaGUgbWFzayBpcyB1c2VkIHRvIG1hc2sgb2ZmIGJvdGgN
Ckl0IHdvcmtzIGZvciBtZS4NCg0KPiBoaWdoIGFkZHJlc3MgYml0cyBhbmQgbG93IGFkZHJlc3Mg
Yml0cyAoYmVsb3cgc3dpb3RsYiBzbG90IGdyYW51bGFyaXR5KS4NCj4gDQo+IFdoYXQgc2hvdWxk
IGhlbHAgaXMgdGhpczoNCj4gLi4uDQpUaGlzIGFsc28gd29ya3MgZm9yIG1lLg0KDQpUaGFua3Ms
ICplaXRoZXIqIHZlcnNpb24gY2FuIHJlc29sdmUgdGhlIGlzc3VlIGZvciBtZSA6LSkNCg==
