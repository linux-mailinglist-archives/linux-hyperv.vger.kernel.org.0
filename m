Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09EC72F359
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Jun 2023 06:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbjFNEFq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Jun 2023 00:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242325AbjFNEFk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Jun 2023 00:05:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2110.outbound.protection.outlook.com [40.107.255.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C67219B9;
        Tue, 13 Jun 2023 21:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2wHuLQo7JsasPl4h1CW6G8TTMYZcOmpjY8AJe8zhuwK7rNnuLmGp6hlwYii+Qk3G+gFUPfb/EkOHyPcKBjuErSUPrUxwHDqClzeuasja1Gafry4BUxTx0o7gX0f26ZJWwfH+H8NK5GzJO2d2Lzxdn+l0ILyHYq6WxC/mKzAZRyHi6Gxh+BFzN81fehy4Q8TnglOlBCU42XLpd8dFxhHUiTOaP7vSttlC6RYvwqyjD8dmLeidnrD9fI6eGlNMnHhfPJNGI/V2aVjyzYAdxw6LvzrUm3GbeUXLNFkoLwBFxkkzUr7+gxWCUHPkqGAvN9TWuRJa6XvyBmpUIm//7Lb5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QWlErMfhtvvKVXy/1A9EXJ3nn4lzaIeC1mu6abWHdmw=;
 b=T6tpZc6TQpZ/TUTY2yUS0F8JqPjGpfDwwMGi4uKEdj5K9RCtcRT9/mZCPBMLNtrYr9LWquNpITxRexcY+PfFQdtGKbr2DCSGyycFUc6Kyp2ouKNk+b1P/ig0zDvrdXcSn0/vv6nQc9deLuVg/b1zIU4tByEgWt8rDvbQxUsBE2MmZ6VGU5DAuN1x18EGeT9Qp+R0NtkwlJ2KqDBN8yWGLhsQxhRed0r2XPTWxNm8/G2pMfuoBhqtRmCVl1aYoiq6b45yTrSu/18HZvJbLvs9g+8+fyY62JqMHg0zrq00znwqZFi0SJmIHEDHGxSA6XefFkkrLLyczgKeGcy3eZiO1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QWlErMfhtvvKVXy/1A9EXJ3nn4lzaIeC1mu6abWHdmw=;
 b=iVY9IcUVOth1rmQMJ+mAihNFOH89SWiqv+yfkcvmn50lJbs0Al0tIbI+1ZHAPbN5QctEi1m20ssRzqRkPi7HIFj/b+9+Uc5NZS35Gt7hoyrjQ2+wEn7GeQwKU08OLnqNQTgo+WRiO3IfmTZkV/T2P6hjgm9gFNpiCLn4HekO884=
Received: from SEZP153MB0742.APCP153.PROD.OUTLOOK.COM (2603:1096:101:94::13)
 by SI2P153MB0653.APCP153.PROD.OUTLOOK.COM (2603:1096:4:1fa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.6; Wed, 14 Jun 2023 04:05:33 +0000
Received: from SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
 ([fe80::6260:f346:f62c:1eec]) by SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
 ([fe80::6260:f346:f62c:1eec%7]) with mapi id 15.20.6521.002; Wed, 14 Jun 2023
 04:05:33 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] x86/hyperv: add noop functions to
 x86_init mpparse functions
Thread-Topic: [EXTERNAL] Re: [PATCH v2] x86/hyperv: add noop functions to
 x86_init mpparse functions
Thread-Index: AQHZnh0lKnuNcu7zBUaRJymNhkyK/q+JpXTQ
Date:   Wed, 14 Jun 2023 04:05:33 +0000
Message-ID: <SEZP153MB0742622EE41C33148CB598DDBE5AA@SEZP153MB0742.APCP153.PROD.OUTLOOK.COM>
References: <1686640391-13001-1-git-send-email-ssengar@linux.microsoft.com>
 <23749756-022a-5574-af4d-a4a03d9542e1@intel.com>
In-Reply-To: <23749756-022a-5574-af4d-a4a03d9542e1@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b3a03ef5-16ad-4ad8-8abb-693a4603898d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-14T03:32:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZP153MB0742:EE_|SI2P153MB0653:EE_
x-ms-office365-filtering-correlation-id: 06aaddfd-14e7-42c3-70b5-08db6c8c99c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /O3+zayU2yh2KOwyF/VPmFqWZxMPD3SsrsKEuBfpahcMnuRY5PFVceHFSfko3gTZB8ElhtHroenji+HFBcg3gOAeHwmJ3KbHuYZtPfpbPMxUDSKsnVB9uUAWlaumbNmZKapQnWQdmo/dxSkVmHLHp+Mw8NpVVUyzacv+ntBqFpdBXhKkF74fLN4510P55WlMY+r7cyuw+KkGBHGEVCVO/6ZBvM0p0Y+4B3fxiRC0HpmoiFn3mHqKFgCmVXHtfg8+27p4joHqQYlH/h155YEtFa70NmRC+dvd2A2iWwPC947ST84l8kM71sZUaDo9dwbFpWwUW0Dl+oh7vgymyhbD3Hrhp0+h8tJfl8MRFySRUOPDFStxnda9hhZonXoZcJug8WNpze77FArpsxArVIQwL3WuMvuBE/CrRP1ibD3hF5Vuz0woeILlRmCfJN+BCaMwFi6OYiKj3pn7o7GRls5Afr+QUNRhhbQWavXiYGR2iiwQzho3Z8Le06qy1zqjflNVGDd4ZmmznR8B3ZtYkk7SqtjvjDIiwJHqbdgkAPZ+/FgrFoDcLURW7WUQ6TeXTVxrIfY3ITlSn147tbdfxW7jqfiH27ky36Y2KG/OH+vrClfGEWC24EMqVf+qM4xeN0sp37nOPSFOrm32awkW6glaHGY7tyn3niwaCTHgDdTOyg8QDWHPRGrtysEZAkcbRJVl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZP153MB0742.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199021)(316002)(7696005)(41300700001)(186003)(8990500004)(83380400001)(2906002)(53546011)(7416002)(86362001)(38070700005)(9686003)(6506007)(33656002)(82950400001)(82960400001)(921005)(122000001)(55016003)(38100700002)(8676002)(52536014)(8936002)(5660300002)(76116006)(66476007)(66946007)(66556008)(478600001)(10290500003)(110136005)(71200400001)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3RWbW5Pb1IvZ3FyZGs1ZjIrVEhpN0hDazE4VXRGa25sTHNSbHNiTGxuczZ1?=
 =?utf-8?B?SklzZUNoeDNQMUJYS1NFbjVwa0FmRHdKQnJTbjlqYStoRmFTbEt1QnlnM0l1?=
 =?utf-8?B?aS8wOXduT0hjd0dDR3hybDFiMEtEbE9ZdEd4YVZ3VFhSTTZFYU1YcWlQVXM5?=
 =?utf-8?B?MG1qWnBVY01xZmFFQjV6eE5Ha0p1MExwYXVIRExFbG81U2JKRFJtWlZzaFF6?=
 =?utf-8?B?YWpUSmk4aGdXWXNqL0FDbHlGQ3gvVGlGOU1jdDZZblh6amtzRXV1UFpCLzN2?=
 =?utf-8?B?U0ZHdmJFc2U2aG9xV1VTQmZlbC9uTTExRHczOFJYc0RpKzRyQ3luZHhKejAw?=
 =?utf-8?B?L0ZPRktwN0lUY0lFMFJOd2NoekNCQkdKb1VNV0w4S3VJaXdlcHpzdms5eTdm?=
 =?utf-8?B?Wkt1VTd2aS9OaDhvem5ITW5ad2Y1czR4SU1BNUxDSEM2Skw0OTUxbGozT3ln?=
 =?utf-8?B?Uy9odkRuMHFjS3JMYkxLbjhqd3ZrK2hod1VXejN5dU9hN0ltZ1hyYnNwMFAz?=
 =?utf-8?B?NkQ5dWJmVFFCeEp6L3ptOHZOaWx2d01VU3R6ZlpPTVRFRWFaYy9jbmhFRXpZ?=
 =?utf-8?B?T3B2TkdGUjcwYVlQd0xicGZ2ZXRCQllLVW9vbFdHQ21WYTVGU0tsMXdqQ1pS?=
 =?utf-8?B?VkdzVHd6R3lZYnJCYUNyMVhSL3MrV1VxdzN6R0lnWWh2SDg3d1IzcVE5ZFNa?=
 =?utf-8?B?dnlzK3ZpVG9jemlnQk5EQTA3dVZrTGU0bGdaY1JrbGVIYmpHbnVyYXRxTHN1?=
 =?utf-8?B?SGhDOVMreXJQWGtDdHhwMXIrcTIxbTZBZ0hybVhqcWtrZU81K3JhYTl5RkJX?=
 =?utf-8?B?Zko3NXRpNzZXNkVpcHo5VC83b3NMaXA3NjBUV1hzeUJyd093MVNOK2hDblRX?=
 =?utf-8?B?OEtkS2pmbXMzYXQ0dFhvUmd2MVZZMDI5THAyc1BCWUhCeHBTZlRleVVUb2J2?=
 =?utf-8?B?dC9pblBuUUxpaE9lY3IzcHF3cUN6UWlzeWJxSzlRbElsN0lHcGRlMFpRQzB3?=
 =?utf-8?B?UjlrS1JCS0Rlaks1UFVVN3I2UjdiR2NyY2liNFMzSExvb09YNmhwSVU1V2RC?=
 =?utf-8?B?cDBCMDN5S2dPVFEzLzliSU1zczVpTFpzS0Q4enhGMW5TMkczVTZRVU1JWUZ6?=
 =?utf-8?B?Y2hUWGYraTV1S3YvbHI5aU9meVpGRk1nUit6cDkzcXhPd20rQzJwQXlsZlR0?=
 =?utf-8?B?VytrK3dNbVM1RTNkV01vdmhPZXF3bncyS2llNE5KQ0FyVW5kbml4SnZzYzUr?=
 =?utf-8?B?STFSMjNNeHVxMVoxWlJZQmhGcjJSMzA4bEVyMS9zTGc4VE5nZ1NmMStlaTlQ?=
 =?utf-8?B?MTRTaThDdTlnaGRXemg0UkRoRXN4VW1GTUpjbU82MlVlM3o5VG1qS3NIc21S?=
 =?utf-8?B?bncwNVdZTU9xSHVWeHlFbmw0MFVqbEhtYzRCeStsbnE4Zk1hRzl3a0NjQU41?=
 =?utf-8?B?bnljTUdGcmFFKzJNZ1lod1pBTHZ6cFVnc0FUTkxKbExKeFFvSG41NllOZHFv?=
 =?utf-8?B?Nm92L1BWTDFzS2ZHWXlZZlhYUXZUcWI4aS9VYy91S0ZKYjB0SnJLWVZLY0dH?=
 =?utf-8?B?bUV0b3dlUnZVemxpMmdzbzlqN0tSWityWnhlOGlxNUNiNlB5cmZuNjQ0MVcr?=
 =?utf-8?B?MXdxT2h2MHhMQmQ4V2E1bUdYOG0yTkhWWUlubk85UC94d0RVdXJjSUNGVzBY?=
 =?utf-8?B?Y1dNSFpvT0RaQUllTFd0bzkxQWN2REVNNXBRVHJyTHZzNmF2YjArTXUzNXFQ?=
 =?utf-8?B?RE1KMEZ5QkpWbXdBbGRSNk1zWDVwVHVOdDAwL0VCU3ltZ1FKc3pPTUZHM1Nv?=
 =?utf-8?B?WkNZMUZOeUUzd1QvRVFuYmtSTlVVVVNzMHhwMnNydVB1eStsQWQybDZEQndU?=
 =?utf-8?B?VTcxR2RBbmszTW1ydlh6d1I1V0kwaExGNlcyNTQydzhaQTBDUk9xa1hTbzA5?=
 =?utf-8?B?Y0NYOVIraHFYcUg2VHlwR0hxVzN3ekJJTk04WmxxSDk2b05jM0czbHNmeHcr?=
 =?utf-8?B?c0ZiZUR2R2VGTDd4Q3hRTHJJUjVKbmF5L0hTbHZjTkJCalAxVTB3ZHZjalU5?=
 =?utf-8?B?cnUzcEZCeGltZUNITURCTGZIREtybUdqck1VaHAzZ0d5TUdBZHk4TEJ6VXZ6?=
 =?utf-8?Q?gMcSsqrlCLDjC7aDR8R04Wqcp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZP153MB0742.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aaddfd-14e7-42c3-70b5-08db6c8c99c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 04:05:33.3656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XDRX4BE/LF/1oxM8Hzm21GHTnQJLJmszRkXIZiQHo7LEvlNPf+iAZiKRFjITbaQz9bmhicaqtFuvgXTeNN2dSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0653
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2ZSBIYW5zZW4gPGRh
dmUuaGFuc2VuQGludGVsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgSnVuZSAxMywgMjAyMyAxMTow
MyBQTQ0KPiBUbzogU2F1cmFiaCBTZW5nYXIgPHNzZW5nYXJAbGludXgubWljcm9zb2Z0LmNvbT47
IEtZIFNyaW5pdmFzYW4NCj4gPGt5c0BtaWNyb3NvZnQuY29tPjsgSGFpeWFuZyBaaGFuZyA8aGFp
eWFuZ3pAbWljcm9zb2Z0LmNvbT47DQo+IHdlaS5saXVAa2VybmVsLm9yZzsgRGV4dWFuIEN1aSA8
ZGVjdWlAbWljcm9zb2Z0LmNvbT47IHRnbHhAbGludXRyb25peC5kZTsNCj4gbWluZ29AcmVkaGF0
LmNvbTsgYnBAYWxpZW44LmRlOyBkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb207DQo+IHg4NkBr
ZXJuZWwub3JnOyBNaWNoYWVsIEtlbGxleSAoTElOVVgpIDxtaWtlbGxleUBtaWNyb3NvZnQuY29t
PjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWh5cGVydkB2Z2VyLmtl
cm5lbC5vcmc7IGhwYUB6eXRvci5jb20NCj4gU3ViamVjdDogW0VYVEVSTkFMXSBSZTogW1BBVENI
IHYyXSB4ODYvaHlwZXJ2OiBhZGQgbm9vcCBmdW5jdGlvbnMgdG8NCj4geDg2X2luaXQgbXBwYXJz
ZSBmdW5jdGlvbnMNCj4gDQo+IE9uIDYvMTMvMjMgMDA6MTMsIFNhdXJhYmggU2VuZ2FyIHdyb3Rl
Og0KPiA+IEluIGNlcnRhaW4gY29uZmlndXJhdGlvbnMsIFZUTDAgYW5kIFZUTDIgY2FuIHNoYXJl
IHRoZSBzYW1lIFZNDQo+ID4gcGFydGl0aW9uIGFuZCBoZW5jZSBzaGFyZSB0aGUgc2FtZSBtZW1v
cnkgYWRkcmVzcyBzcGFjZS4gSW4gc3VjaA0KPiA+IHN5c3RlbXMgVlRMMiBoYXMgdmlzaWJpbGl0
eSBvZiBhbGwgb2YgdGhlIFZUTDAgbWVtb3J5IHNwYWNlLg0KPiANCj4gRldJVywgdGhpcyBpcyBw
cmV0dHkgbXVjaCBnaWJiZXJpc2ggdG8gbWUuICBUaGUgd2F5IEkgc3VnZ2VzdCBhdm9pZGluZw0K
PiBwcm9kdWNpbmcgZ2liYmVyaXNoIGlzIGF2b2lkaW5nIGFjcm9ueW1zOg0KPiANCj4gCUh5cGVy
LVYgY2FuIHJ1biBWTXMgYXQgZGlmZmVyZW50IHByaXZpbGVnZSAibGV2ZWxzIi4gIFNvbWV0aW1l
cywNCj4gCWl0IGNob29zZXMgdG8gcnVuIHR3byBkaWZmZXJlbnQgVk1zIGF0IGRpZmZlcmVudCBs
ZXZlbHMgYnV0DQo+IAl0aGV5IHNoYXJlIHNvbWUgb2YgdGhlaXIgYWRkcmVzcyBzcGFjZS4gIFRo
aXMgPGluc2VydCByZWFzb24NCj4gCXRoYXQgc29tZW9uZSBtaWdodCB3YW50IHRvIGRvIHRoaXM+
Lg0KPiANCj4gVGhhdCdzIG5vdCBnaWJiZXJpc2guDQoNClRoYW5rcyBmb3IgeW91ciBzdWdnZXN0
aW9uIEkgY2FuIGFkZCB0aGlzIGluIHYzLg0KDQo+IA0KPiA+IFdoZW4gQ09ORklHX1g4Nl9NUFBB
UlNFIGlzIGVuYWJsZWQgZm9yIFZUTDIsIHRoZSBrZXJuZWwgcGVyZm9ybXMgYQ0KPiA+IHNjYW4g
b2YgbG93IG1lbW9yeSB0byBzZWFyY2ggZm9yIE1QIHRhYmxlcy4gSG93ZXZlciwgaW4gc3lzdGVt
cyB3aGVyZQ0KPiA+IFZUTDAgY29udHJvbHMgdGhlIGxvdyBtZW1vcnkgYW5kIG1heSBjb250YWlu
IHZhbGlkIHRhYmxlcyBzcGVjaWZpYyB0bw0KPiA+IFZUTDAsIHRoaXMgc2Nhbm5pbmcgcHJvY2Vz
cyBjYW4gbGVhZCB0byBjb25mdXNpb24gd2l0aGluIHRoZSBWVEwyDQo+ID4ga2VybmVsLg0KPiAN
Cj4gV2hhdCBpcyB0aGUgZW5kLXVzZXItdmlzaWJsZSBlZmZlY3Qgb2YgdGhpcyAiY29uZnVzaW9u
Ij8gIEEgY3Jhc2g/ICBBIHdhcm5pbmc/DQo+IEFuIGVycm9yIG1lc3NhZ2U/ICBXaGF0IGlzIHRo
ZSBpbXBhY3Qgb24gZW5kIHVzZXJzPw0KDQpUaGUgVlRMMiBrZXJuZWwgaXMgY3VycmVudGx5IHNj
YW5uaW5nIHRoZSBWVEwwIE1QIHRhYmxlIGFuZCBpbmNvcnBvcmF0aW5nIHRoYXQNCmluZm9ybWF0
aW9uLCB3aGljaCBpcyBpbmNvcnJlY3QgYmVjYXVzZSBWVEwyIGRvZXNuJ3Qgc3VwcG9ydCBNUCB0
YWJsZXMgYW5kDQppbnN0ZWFkLCBpcyBib290ZWQgd2l0aCBEVC4gV2hpbGUgSSBkb24ndCBoYXZl
IGFuIGltbWVkaWF0ZSBjcmFzaCBvciBlcnJvcg0KbWVzc2FnZSB0byBwcmVzZW50LCB0aGlzIHNp
dHVhdGlvbiBjb3VsZCBwb3RlbnRpYWxseSByZXN1bHQgaW4gaW5jb3JyZWN0IGJlaGF2aW91ci4N
Cg0KPiANCj4gVGhpcyBpbmZvcm1hdGlvbiB3aWxsIGhlbHAgdGhlIG1haW50YWluZXJzIGRlY2lk
ZSBob3cgdG8gZGlzcG9zaXRpb24geW91cg0KPiBwYXRjaC4gIFNob3VsZCB3ZSBzZW5kIGl0IHVw
c3RyZWFtIGltbWVkaWF0ZWx5IGJlY2F1c2UgaXQncyBpbXBhY3RpbmcNCj4gbWlsbGlvbnMgb2Yg
dXNlcnM/ICBPciBjYW4gd2UgZG8gaXQgaW4gYSBiaXQgbW9yZSBsZWlzdXJlbHkgZmFzaGlvbiBi
ZWNhdXNlDQo+IG5vYm9keSBjYXJlcz8NCg0KSSB1bmRlcnN0YW5kLCBJIGhhdmUgcHJvdmlkZWQg
YWxsIHRoZSBpbmZvcm1hdGlvbiBJIGhhdmUgcGxlYXNlIGNvbnNpZGVyIHdoYXQgaXMNCmFwcHJv
cHJpYXRlIGluIHRoaXMgY2FzZS4NCg0KPiANCj4gPiBJbiAhQUNQSSBzeXN0ZW0sIHRoZXJlIGlz
IG5vIHdheSB0byBkaXNhYmxlIENPTkZJR19YODZfTVBQQVJTRSBoZW5jZQ0KPiA+IGFkZCB0aGUg
bm9vcCBmdW5jdGlvbiBpbnN0ZWFkLg0KPiANCj4gVGhpcyBtYWtlcyB6ZXJvIHNlbnNlIHRvIG1l
Lg0KDQpNeSBpbnRlbnRpb24gd2FzIHRvIHRlbGwgdGhhdCB0aGlzIGZpeCBpcyByZXF1aXJlZCBi
ZWNhdXNlIHdlIGFyZSBpbiAhQUNQSSBzeXN0ZW0uDQpJZiBpdCB3YXMgQUNQSSBzeXN0ZW0gd2Ug
Y291bGQgaGF2ZSBzaW1wbHkgZGlzYWJsZSB0aGlzIENPTkZJR19YODZfTVBQQVJTRQ0KT3B0aW9u
LiBCdXQgYXMgeW91IHN1Z2dlc3RlZCBJIGFtIGZpbmUgcmVtb3ZpbmcgdGhlc2UgMiBsaW5lcy4N
Cg0KPiANCj4gTGlrZSBJIHRvbGQgeW91IGJlZm9yZSwgd2UgZG9uJ3QgY29tcGlsZSB0aGluZ3Mg
b3V0IGp1c3QgYmVjYXVzZSB0aGV5IGRvbid0DQo+IHdvcmsgb24gb25lIHdlaXJkbyBzeXN0ZW0u
ICBJZiB3ZSBkaWQgdGhhdCwgd2UnZCBoYXZlIGEgYmlsbGlvbiBpbmNvbXBhdGlibGUNCj4geDg2
IGtlcm5lbCBpbWFnZXMgdGhhdCBjYW4ndCBib290IGFjcm9zcyBzeXN0ZW1zLg0KPiANCg0KVW5k
ZXJzdG9vZCwgdGhhbmsgeW91LiBJIHdhcyBqdXN0IGNvbnNpZGVyaW5nIHRoZSBvcHRpb24gb2Yg
a2VlcGluZyB0aGUgZGVmYXVsdA0Kc2V0dGluZyBmb3IgQ09ORklHX1g4Nl9NUFBBUlNFIGFzICdZ
JyBhbmQgYWxsb3dpbmcgdGhlIGNob2ljZSB0byBjaGFuZ2UgaXQgdG8NCidOJyBpZiBzb21lb25l
IHNwZWNpZmljYWxseSBkZXNpcmVzIHRvIGRvIHNvLiBJIGFsc28gY29uc2lkZXJlZCB0aGF0IG5v
d2FkYXlzLCBub3QNCm1hbnkga2VybmVscyBhcmUgbGlrZWx5IHRvIHV0aWxpemUgTVAgdGFibGVz
IGZvciBib290aW5nIHg4NiBtYWNoaW5lcywgd2hpY2ggaXMgd2h5DQpJIHRob3VnaHQgdGhpcyBj
aGFuZ2Ugd291bGRuJ3QgaGF2ZSBhIHNpZ25pZmljYW50IGltcGFjdC4gTW9yZW92ZXIsIHRoZXJl
IGlzIGENCnBvdGVudGlhbCBiZW5lZml0IGluIHRlcm1zIG9mIHJlZHVjaW5nIHRoZSBrZXJuZWwn
cyBzaXplLiBIb3dldmVyLCBJIGNvbXBsZXRlbHkNCnJlc3BlY3QgYW5kIGFtIG9wZW4gdG8gd2hh
dGV2ZXIgeW91IGRlY2lkZSwgaGF2aW5nIGJldHRlciB2aXNpYmlsaXR5IG9mIHdpZGVyDQprZXJu
ZWwgY29tbXVuaXR5IG5lZWRzLg0KDQotIFNhdXJhYmgNCg==
