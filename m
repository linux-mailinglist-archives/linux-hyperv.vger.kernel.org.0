Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4A74DD415
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Mar 2022 06:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiCRFO1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Mar 2022 01:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbiCRFO0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Mar 2022 01:14:26 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11020026.outbound.protection.outlook.com [52.101.56.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405DF134;
        Thu, 17 Mar 2022 22:13:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIaWOUMalxIXWGdcUT+wyVvGJnO4eET3UGFZTmkeoLqtpMQbjkPmD4ga6l/pgbFTKKeEbAudyjUo3FAb1KIkMz7/RC9NPQQDFlq5CNn22zvfJUD2rSmBPCFIJu5EP4XS9PvvdGie7zilAXBgQOpvcI/ehG6TnX6WZSXgoKsyHv0d+RVtelj8q9/tXH70R0qDBaMBkW12AhDMQ8go9eQAnHvOUUgEHIEnYdfLzRU8II5PuUFUvTkm/PeHVdCxdRTnoYYQbGoDrwVqBJFjv2MmG+LMsKeMwtlaF0MnxntQZXg5LfQ7+P7IEKWZ1APbDiH6QiIQ64VoJbs7byIv6EhPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drdLC9M+ZAveSPuI87rpXPqL6vFqltjDVfNTnL7M5FI=;
 b=MycaaLhwCQ6Wks7BVTqHOKrx8rMfBl40INizDPAEKEJB8rqlfok8P2qrFyp50mKhgxNKW3j677M801kIh1BV2KEKMcVUX3mmF2bqa/06Z4BrKFV5sfB2hWRmqFfzwt/J2M6MHnZWOibR5a6TlYmNqk31w9+O27lA2W4OLmgg0iGuv7e0cgF/sI8pejDBaZT3q1VTGp9S+hBkb6WQcbcCi7UgePsNpY8i4b9sgRoO/qM54DUlmqsq8ccu6x5Tk/9HGj7XBNjDG74uokLzFH++GrFm2HDtiR77J2lrvOp0b3daTaumNiSLHwX1MqO4xuojxZNPb4cfZ3Y6jhYqUUb4+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drdLC9M+ZAveSPuI87rpXPqL6vFqltjDVfNTnL7M5FI=;
 b=E1156XXa0ANgz3lvJ5hVJPm9duH663GNmcFyiTUkCVyvL8K7tAFmO8yo8UScxnhU7HtvajERPbGpKqfJNhnzm9qZCqyrpDfH/STq+jzJchhE/oHGhjr3gy9hM7yIbgRF/JIQu38NImpZ/RTW3PxIlgdi3lokCl0lwfnlOvJAVkU=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by DM6PR21MB1466.namprd21.prod.outlook.com (2603:10b6:5:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Fri, 18 Mar
 2022 05:13:03 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::44a2:4767:f55:7f2b%5]) with mapi id 15.20.5081.013; Fri, 18 Mar 2022
 05:12:57 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "hch@lst.de" <hch@lst.de>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus device
 to PCI device
Thread-Topic: [PATCH 4/4 RESEND] PCI: hv: Propagate coherence from VMbus
 device to PCI device
Thread-Index: AQHYOhuoZPOAPXCXP0q01eTUICYXTKzD0PMAgADGUgA=
Date:   Fri, 18 Mar 2022 05:12:56 +0000
Message-ID: <PH0PR21MB302533BCD6707DAACC13E64DD7139@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-5-git-send-email-mikelley@microsoft.com>
 <9c52c5a0-163d-e2dd-d95b-9f382e665215@arm.com>
In-Reply-To: <9c52c5a0-163d-e2dd-d95b-9f382e665215@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bc4ff47c-b5d9-4f99-8999-baf3e627d00a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-18T05:05:11Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6b5710b-d766-4eb2-8eb2-08da089df6d7
x-ms-traffictypediagnostic: DM6PR21MB1466:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <DM6PR21MB146695175A86A4F8E7AB9745D7139@DM6PR21MB1466.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Cr3hxrN8cjQZrLERscsG1/FFzhBAEcjp9e4dd/D8rxopMhNuYC+gOgKaS9INF6rmN7EgqMlA4VGR3nZCtbWF983xGAqJ2ZDcecUcXB8yvfNtz1xfy0O6H2slVtyrtLoJQy8WgUheEHn8Rd/dfbYKL1lEbyeH/kCtmkz/+z40JDjC4WgUjT3bylrf4j3PQbkwcZPBokFahD7sygeCwNBDf9zQ7UW9dDSgOmkQD//kIhpNPQi8Qv+aSzSCkLO0kBIGjVnyI/Zg1vtcD7s30SAu4rs7hl4sQGKxZ2w0CpvpAGIzkmsf6jyPEn+m3bnjsFQnxsun8pB+V/FnqSQxg/imxr5Rsb3Y0GpcQ2DsIZ5rjeol000JtJZRq01YWjdmDYVX6rP/kL9jRDifscHwjz4spzw97e60yOhlK1/UrlY68dvOjlqxJ5A+jKPmaPfaM5Y8ApPS3FFwObGnqpyGDD2UUjZrBJ0ha5bVmmuihMZEEpLss+sm5p3cLqeYTX1gljzrqa0fgoIKir4ROEKt3qWp+ZeBlus4AqJb1B//glmyr2e7hKHNvMs1KoYu5/CuAeyHWBr9IqaQP/D3vVSozZGDUkSF7vGNFhGFlG3S7Z2hQ9d6dn2T5dzngvT3yOe7NI118W/kVPfBhpZPhQBpsS5E4ruJ0zEwOiT87OWawMdb1eEEKWuzKmo/2LVvYuk6TigodsMzNxNlVaY+LIKby5ZP2WaPNlIrOPBXkMx7I5/LX2XCrMQTCfXpRRuJi5LRKcNsne3iOsjje2diTENabCH1cQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(6506007)(508600001)(82960400001)(10290500003)(110136005)(8990500004)(82950400001)(53546011)(55016003)(921005)(7416002)(8676002)(66476007)(66946007)(71200400001)(316002)(86362001)(5660300002)(66556008)(64756008)(66446008)(76116006)(52536014)(38070700005)(186003)(26005)(122000001)(9686003)(33656002)(7696005)(83380400001)(8936002)(38100700002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bjNBbWdpSUxXK1R4U3dKcndwU1l4NmZsZGpNdG5NUFhxcUVsZjJ2cHp5TW5G?=
 =?utf-8?B?R2VNemhKbU9TdHUzWndxZVZCcFd0SXloekJvNnNMQ0lFdzMwYTlSWldPdXJF?=
 =?utf-8?B?cDJ0eGxZTHAvSUhrR0crMzdCVkdZMm1uT0N3eFhzY0wraUdBeFpIb0xLV1Jy?=
 =?utf-8?B?RysyWWo5U2k4bWwzaG9CN09XTDBuSUJhcERJMmFneGNmT2kyRS9tWGsrUlQv?=
 =?utf-8?B?Ykh1Y0JJZE5LOUZEWkFmMzVyaEtOMnRzRGF6cEx3ZElSVjk3K2hZRmo5WjZY?=
 =?utf-8?B?c3dNcmplOGRrazcxZEtKcmlEbGU0d0lSUkFQMC9WVGJObU9GR1FyTVk1bFl3?=
 =?utf-8?B?c1dpN1N0U1o0UU05dFRDaXB5UEdtUUw1YVZQR1RQZUdrU09TMjR5UWNlQ2FJ?=
 =?utf-8?B?djNPWUNiNGZYeVRKejZlZVFGL0VFaDU2UDNidzhmaUtxTnpDWDlWRzZzdUxH?=
 =?utf-8?B?dmhZNzVxMjRGRTVycllxNGFYRkJVbld5bGlxSlJNT2wrSFF5UzZXci8ybitB?=
 =?utf-8?B?bFpyczhGMzEzNmdHMDA4ckl6M1NXSGJJQWZmaXYra3ZwUzJKcHpvNld6UHBt?=
 =?utf-8?B?NGIvdGFycVpBd2dGdWFHeVZjeFRFdGhWQnJBckh0TjJnaURDamFMZXI4VVdj?=
 =?utf-8?B?OWRyTnJOOXRwOC9aSk12ODFZczI3dDJjMEI5eGdoVktnS1ZIamxmM1JnRGJq?=
 =?utf-8?B?Rnl5eU13SlMwRjJyVTYzb1hUcG93Q1JMRi9weFM0ODJxQk5PV1FpcUF6YVRD?=
 =?utf-8?B?eGkvMlNKc0FlQ2VIKzF2ZFQ1RmhRL3JoZG9SelJROVIzb1diOHo0K2djaFFm?=
 =?utf-8?B?cEsxVVFKWEFaeC85aUt5eTJDWXBxQ1VSbFJYOXYweTc3N2RwY25LS1lSWFpX?=
 =?utf-8?B?ZFpGeEVZcDEvKzYrYlhmV2ZHRzhGRGRXM2lQY1hYMXpkTmhhKzNSZmdTN1Ux?=
 =?utf-8?B?ZGFRZGM2SWZzdThHeS9rMDVQNTJydXBuT3ZoSllDRXM0ZnVLMkFDSXk0dFBE?=
 =?utf-8?B?U0J1REJibHIwUlFCSk44VWhPMEpSdkxVbFJsVkFEcmhSZDRXOFFpUE9YOFhG?=
 =?utf-8?B?MDRmb2R1ZFgwdE1ONTM2SldLbFc1YmVKRVYxTkx1Vk9FWlNObHlvbGFqRU9Y?=
 =?utf-8?B?YTQwUkRKRSsra2tUNzBGN3hYMEo3ZnBJZHdhOFB1SHU2MmxNWllmU2s3Vkcv?=
 =?utf-8?B?d0ZSWjBVT3QxS2lYNThLdVd0d0YzZTlsZGRabXlRMU5TeVQxcnlVMHIxV3lm?=
 =?utf-8?B?Uy9DcTh3QjR2Mk9XcEpYaDlZQVpVekwzM0Z3NGF6VC8wZ1V4a2hQbTZ1dmpL?=
 =?utf-8?B?OFpsT21vd2tQUmRYd2JGMy9uQXZLSWNyMEQxa2M1QUZ5b0Jxa2RtbTNscUZX?=
 =?utf-8?B?RTZ6N2w3dDN6ZlQvaXRnalNCMG9nWFVkUDVKVDFIMmh0cklVd2pNRUoxdVZ2?=
 =?utf-8?B?cUgycEVRdWhhenV5aTZHbW5oT01vblRldXZhTUJXYkxvN2hKMWpCTmtaMTZm?=
 =?utf-8?B?NlpEaDVBRk1wWldIZUhPaFRnTmJRTEc3L0RON3ZCTFlqUGk1SjY0dWI1Skg3?=
 =?utf-8?B?aEJlU0R0dTdOZFZxRG9pUlVUSVVpa0lLSE5aLzFFS2tlZ1ZrZGdSVUtYNG1t?=
 =?utf-8?B?SjJtMlZDZHd1K0NSV1dMK0liaXVTYUFKbDNzQ09SakRmaElCQno5emxTRXNz?=
 =?utf-8?B?TmRDK3dCeTB1NVJTMVdDRW9BaVBUUERkb3o2dnplS0dCVzVFNU5VRGdQdnlI?=
 =?utf-8?B?Q0dpaGUxcFByOVFlZGZQd003QWJWckIydTZJbWVrQ1pGV1JnVEU4NWQxNE1U?=
 =?utf-8?B?VFpuakd5cmczU3BPWndHVmVrWGNOWmZ0TUJ1UHhvZHhTMWczSFI1OWFNTFpM?=
 =?utf-8?B?d3NKeHIrSFV1TDFJT3F1TngxOEgxY0xOdG9OYVVRalpHRUdzTldrZlFROTBh?=
 =?utf-8?B?eGN6L3pyMkFrM3ZMcXY3WlU2d1Q1U2xSQTN0eFRCU2x2dlNjNGtKSVllN0dM?=
 =?utf-8?B?cXd3UzJNcGJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b5710b-d766-4eb2-8eb2-08da089df6d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 05:12:56.7755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r9lwAvjQmsDwiwCgo1Z7qpQfsnrXly65Q4HIEmcfUgYGYD9IBJXbM3DqRXey4IGqZmlhxzrzacSaYB64t9rxdWsm3zXRPHZDKWY4vux6NO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1466
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogVGh1cnNkYXks
IE1hcmNoIDE3LCAyMDIyIDEwOjE1IEFNDQo+IA0KPiBPbiAyMDIyLTAzLTE3IDE2OjI1LCBNaWNo
YWVsIEtlbGxleSB2aWEgaW9tbXUgd3JvdGU6DQo+ID4gUENJIHBhc3MtdGhydSBkZXZpY2VzIGlu
IGEgSHlwZXItViBWTSBhcmUgcmVwcmVzZW50ZWQgYXMgYSBWTUJ1cw0KPiA+IGRldmljZSBhbmQg
YXMgYSBQQ0kgZGV2aWNlLiAgVGhlIGNvaGVyZW5jZSBvZiB0aGUgVk1idXMgZGV2aWNlIGlzDQo+
ID4gc2V0IGJhc2VkIG9uIHRoZSBWTWJ1cyBub2RlIGluIEFDUEksIGJ1dCB0aGUgUENJIGRldmlj
ZSBoYXMgbm8NCj4gPiBBQ1BJIG5vZGUgYW5kIGRlZmF1bHRzIHRvIG5vdCBoYXJkd2FyZSBjb2hl
cmVudC4gIFRoaXMgcmVzdWx0cw0KPiA+IGluIGV4dHJhIHNvZnR3YXJlIGNvaGVyZW5jZSBtYW5h
Z2VtZW50IG92ZXJoZWFkIG9uIEFSTTY0IHdoZW4NCj4gPiBkZXZpY2VzIGFyZSBoYXJkd2FyZSBj
b2hlcmVudC4NCj4gPg0KPiA+IEZpeCB0aGlzIGJ5IHByb3BhZ2F0aW5nIHRoZSBjb2hlcmVuY2Ug
b2YgdGhlIFZNYnVzIGRldmljZSB0byB0aGUNCj4gPiBQQ0kgZGV2aWNlLiAgVGhlcmUncyBubyBl
ZmZlY3Qgb24geDg2L3g2NCB3aGVyZSBkZXZpY2VzIGFyZQ0KPiA+IGFsd2F5cyBoYXJkd2FyZSBj
b2hlcmVudC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtlbGxl
eUBtaWNyb3NvZnQuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2ktaHlwZXJ2LmMgfCAxNyArKysrKysrKysrKysrLS0tLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQs
IDEzIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaS1oeXBlcnYuYw0KPiA+IGluZGV4IGFlMGJjMmYuLjE0Mjc2ZjUgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMNCj4gPiArKysgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiA+IEBAIC00OSw2ICs0OSw3IEBADQo+
ID4gICAjaW5jbHVkZSA8bGludXgvcmVmY291bnQuaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9p
cnFkb21haW4uaD4NCj4gPiAgICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+DQo+ID4gKyNpbmNsdWRl
IDxsaW51eC9kbWEtbWFwLW9wcy5oPg0KPiA+ICAgI2luY2x1ZGUgPGFzbS9tc2h5cGVydi5oPg0K
PiA+DQo+ID4gICAvKg0KPiA+IEBAIC0yMTQyLDkgKzIxNDMsOSBAQCBzdGF0aWMgdm9pZCBodl9w
Y2lfcmVtb3ZlX3Nsb3RzKHN0cnVjdCBodl9wY2lidXNfZGV2aWNlDQo+ICpoYnVzKQ0KPiA+ICAg
fQ0KPiA+DQo+ID4gICAvKg0KPiA+IC0gKiBTZXQgTlVNQSBub2RlIGZvciB0aGUgZGV2aWNlcyBv
biB0aGUgYnVzDQo+ID4gKyAqIFNldCBOVU1BIG5vZGUgYW5kIERNQSBjb2hlcmVuY2UgZm9yIHRo
ZSBkZXZpY2VzIG9uIHRoZSBidXMNCj4gPiAgICAqLw0KPiA+IC1zdGF0aWMgdm9pZCBodl9wY2lf
YXNzaWduX251bWFfbm9kZShzdHJ1Y3QgaHZfcGNpYnVzX2RldmljZSAqaGJ1cykNCj4gPiArc3Rh
dGljIHZvaWQgaHZfcGNpX2Fzc2lnbl9wcm9wZXJ0aWVzKHN0cnVjdCBodl9wY2lidXNfZGV2aWNl
ICpoYnVzKQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBwY2lfZGV2ICpkZXY7DQo+ID4gICAJc3Ry
dWN0IHBjaV9idXMgKmJ1cyA9IGhidXMtPmJyaWRnZS0+YnVzOw0KPiA+IEBAIC0yMTY3LDYgKzIx
NjgsMTQgQEAgc3RhdGljIHZvaWQgaHZfcGNpX2Fzc2lnbl9udW1hX25vZGUoc3RydWN0DQo+IGh2
X3BjaWJ1c19kZXZpY2UgKmhidXMpDQo+ID4gICAJCQkJICAgICBudW1hX21hcF90b19vbmxpbmVf
bm9kZSgNCj4gPiAgIAkJCQkJICAgICBodl9kZXYtPmRlc2MudmlydHVhbF9udW1hX25vZGUpKTsN
Cj4gPg0KPiA+ICsJCS8qDQo+ID4gKwkJICogT24gQVJNNjQsIHByb3BhZ2F0ZSB0aGUgRE1BIGNv
aGVyZW5jZSBmcm9tIHRoZSBWTWJ1cyBkZXZpY2UNCj4gPiArCQkgKiB0byB0aGUgY29ycmVzcG9u
ZGluZyBQQ0kgZGV2aWNlLiBPbiB4ODYveDY0LCB0aGVzZSBjYWxscw0KPiA+ICsJCSAqIGhhdmUg
bm8gZWZmZWN0IGJlY2F1c2UgRE1BIGlzIGFsd2F5cyBoYXJkd2FyZSBjb2hlcmVudC4NCj4gPiAr
CQkgKi8NCj4gPiArCQlkZXZfc2V0X2RtYV9jb2hlcmVudCgmZGV2LT5kZXYsDQo+ID4gKwkJCWRl
dl9pc19kbWFfY29oZXJlbnQoJmhidXMtPmhkZXYtPmRldmljZSkpOw0KPiANCj4gRXd3Li4uIGlm
IHlvdSByZWFsbHkgaGF2ZSB0byBkbyB0aGlzLCBJJ2QgcHJlZmVyIHRvIHNlZSBhIHByb3Blcg0K
PiBodl9kbWFfY29uZmlndXJlKCkgaGVscGVyIGltcGxlbWVudGVkIGFuZCB3aXJlZCB1cCB0bw0K
PiBwY2lfZG1hX2NvbmZpZ3VyZSgpLiBBbHRob3VnaCBzaW5jZSBpdCdzIGEgZ2VuZXJpYyBwcm9w
ZXJ0eSBJIGd1ZXNzIGF0DQo+IHdvcnN0IHBjaV9kbWFfY29uZmlndXJlIGNvdWxkIHBlcmhhcHMg
cHJvcGFnYXRlIGNvaGVyZW5jeSBmcm9tIHRoZSBob3N0DQo+IGJyaWRnZSB0byBpdHMgY2hpbGRy
ZW4gYnkgaXRzZWxmIGluIHRoZSBhYnNlbmNlIG9mIGFueSBvdGhlciBmaXJtd2FyZQ0KPiBpbmZv
LiBBbmQgaXQncyBidWlsdC1pbiBzbyBjb3VsZCB1c2UgYXJjaF9zZXR1cF9kbWFfb3BzKCkgbGlr
ZSBldmVyeW9uZQ0KPiBlbHNlLg0KPiANCg0KSSdtIG5vdCBzZWVpbmcgYW4gZXhpc3RpbmcgbWVj
aGFuaXNtIHRvIHByb3ZpZGUgYSAiaGVscGVyIiBvciBvdmVycmlkZQ0Kb2YgcGNpX2RtYV9jb25m
aWd1cmUoKS4gICBDb3VsZCB5b3UgZWxhYm9yYXRlPyAgT3IgaXMgdGhpcyBzb21ldGhpbmcNCnRo
YXQgbmVlZHMgdG8gYmUgY3JlYXRlZD8NCg0KTWljaGFlbA0KDQo+IFJvYmluLg0KPiANCj4gPiAr
DQo+ID4gICAJCXB1dF9wY2ljaGlsZChodl9kZXYpOw0KPiA+ICAgCX0NCj4gPiAgIH0NCj4gPiBA
QCAtMjE5MSw3ICsyMjAwLDcgQEAgc3RhdGljIGludCBjcmVhdGVfcm9vdF9odl9wY2lfYnVzKHN0
cnVjdCBodl9wY2lidXNfZGV2aWNlDQo+ICpoYnVzKQ0KPiA+ICAgCQlyZXR1cm4gZXJyb3I7DQo+
ID4NCj4gPiAgIAlwY2lfbG9ja19yZXNjYW5fcmVtb3ZlKCk7DQo+ID4gLQlodl9wY2lfYXNzaWdu
X251bWFfbm9kZShoYnVzKTsNCj4gPiArCWh2X3BjaV9hc3NpZ25fcHJvcGVydGllcyhoYnVzKTsN
Cj4gPiAgIAlwY2lfYnVzX2Fzc2lnbl9yZXNvdXJjZXMoYnJpZGdlLT5idXMpOw0KPiA+ICAgCWh2
X3BjaV9hc3NpZ25fc2xvdHMoaGJ1cyk7DQo+ID4gICAJcGNpX2J1c19hZGRfZGV2aWNlcyhicmlk
Z2UtPmJ1cyk7DQo+ID4gQEAgLTI0NTgsNyArMjQ2Nyw3IEBAIHN0YXRpYyB2b2lkIHBjaV9kZXZp
Y2VzX3ByZXNlbnRfd29yayhzdHJ1Y3Qgd29ya19zdHJ1Y3QNCj4gKndvcmspDQo+ID4gICAJCSAq
Lw0KPiA+ICAgCQlwY2lfbG9ja19yZXNjYW5fcmVtb3ZlKCk7DQo+ID4gICAJCXBjaV9zY2FuX2No
aWxkX2J1cyhoYnVzLT5icmlkZ2UtPmJ1cyk7DQo+ID4gLQkJaHZfcGNpX2Fzc2lnbl9udW1hX25v
ZGUoaGJ1cyk7DQo+ID4gKwkJaHZfcGNpX2Fzc2lnbl9wcm9wZXJ0aWVzKGhidXMpOw0KPiA+ICAg
CQlodl9wY2lfYXNzaWduX3Nsb3RzKGhidXMpOw0KPiA+ICAgCQlwY2lfdW5sb2NrX3Jlc2Nhbl9y
ZW1vdmUoKTsNCj4gPiAgIAkJYnJlYWs7DQo=
