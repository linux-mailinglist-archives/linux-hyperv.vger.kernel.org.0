Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C09F4DE293
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Mar 2022 21:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbiCRUiR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 18 Mar 2022 16:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbiCRUiR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 18 Mar 2022 16:38:17 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0666D19530D;
        Fri, 18 Mar 2022 13:36:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSXf2KmL8JbD7jKqG4Rvtz0pse60CwO/OXVW/aN2BeQtwCgl57mK2HHkIYdwsjmC1CKCFdVn29xRm3o1+MScJUNCrG41XE65KOfTXn92eU+4i0eaMZQvn8Qci4RvgCdDxhvzP2nMbs1i6f37H4F+eJ4AgLA9LGCtqm32ZhWUhBwaKXqa1GbtGE9eoP4qvykhk3fHLrQmVjsUlqCnKu8rqfrTcobfpJdsJxItOPaUMFq+vDXwfJtwUlPF2ouwablZ/6YK9SDzXKwdZePpReWIXyEJKqsPLSFW+O6otUzYVJPyP8tg40a135ymmxbyK81dOQkrfA9A7qZU8SjzZ0rqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/nPXJjHcEKecEzoPVidNfplBM3Thyjxv1bK6hthw8g=;
 b=Gw8XFBK3bMNP+48VOBLo+fwkekwVgOyFFPrnOof6LUNl7WSwm4kad68QwN5cEJGNn1h1KhiO1OUUpcAUKqbHB4gRzERbxl+KD6k82xVwimbTGAxcqSopk6eCZdvB8tCQ4ptJ8so+t5eOhCf0zmvNhOT4P5hPQDAp7fzXyiE6WJfwZHykyU3xIZ3BJCjpEB/6ic4/cRi3cailB3GDmdchx1zc2e1zDOAE7T9uqXaKAHCwwOroYoN2WUP7rUn0hcFET6bhsCn1cWhGduw4NXvuSdBtpKy/N0ILcAnWcolzOZnYJaX7a+X64hEFtk1Ti6DNYQFgnBzZmJlyOLfb+ciC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/nPXJjHcEKecEzoPVidNfplBM3Thyjxv1bK6hthw8g=;
 b=FVvZ1HDrfWVkM1T+a/U8jRXbOSncERkTwhnNQRvlwAeBDuGKce384/PYTnK9DXDikGRs4truEGZZHpeYtVTwhRQv2yu7wu7Tf+Jn9UawIV7uy4ouLEfqrhdmPudhbqNlyfnvDDZPUkqKSuaBJqip5+BMii3ug5mmf5fh/tlfI9o=
Received: from BY3PR21MB3033.namprd21.prod.outlook.com (2603:10b6:a03:3b3::5)
 by BYAPR21MB1206.namprd21.prod.outlook.com (2603:10b6:a03:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Fri, 18 Mar
 2022 20:36:53 +0000
Received: from BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::ed64:ab10:6089:b736]) by BY3PR21MB3033.namprd21.prod.outlook.com
 ([fe80::ed64:ab10:6089:b736%3]) with mapi id 15.20.5102.011; Fri, 18 Mar 2022
 20:36:53 +0000
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
Thread-Index: AQHYOhuoZPOAPXCXP0q01eTUICYXTKzD0PMAgADGUgCAAGKTgIAAm9MA
Date:   Fri, 18 Mar 2022 20:36:53 +0000
Message-ID: <BY3PR21MB3033B9B260CEA13A5C2DE9ECD7139@BY3PR21MB3033.namprd21.prod.outlook.com>
References: <1647534311-2349-1-git-send-email-mikelley@microsoft.com>
 <1647534311-2349-5-git-send-email-mikelley@microsoft.com>
 <9c52c5a0-163d-e2dd-d95b-9f382e665215@arm.com>
 <PH0PR21MB302533BCD6707DAACC13E64DD7139@PH0PR21MB3025.namprd21.prod.outlook.com>
 <44dd4f16-3f0b-5289-c9a2-fe42341b0231@arm.com>
In-Reply-To: <44dd4f16-3f0b-5289-c9a2-fe42341b0231@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=40410c4c-4fe6-4590-87dd-3a15d3df77b1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-18T20:15:42Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2d6d12d-f775-4fc1-8e34-08da091f0983
x-ms-traffictypediagnostic: BYAPR21MB1206:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <BYAPR21MB1206D622B9859B5338D183C6D7139@BYAPR21MB1206.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L6FW/WXH+e25DUAJrmk/Nb3idJIq4RxqWwT8risSYHt04BHkpnORL4tikHmxUWBt8alp1c8FeGIQw43LQDG+Wp/bCGDaLRL9m0xR68V1ghZG27JgHdPgV6VTaP+jTmN9kyPQwEf4GUI811k8cGqJitOEi1UomOIYm+JlkG5zWYUeVb439KW9mcrRUJK5fEfDrsChiAukggY5jLZgIcxEVJ+mfRLphYhJGuSChRNNLZCCrmMrt0ZTPYgqQEZfHqvplYJQhKrNT/5zwCpDbDBdEgYdKMmB+3PW7zWzIqaQhox+0wCM0o6eRuOxEhDcN4/+sdONkrO+tkMr4HalrJWKDTIk2VULlkhihMwtrkjJQ9tqINT5X7bpEEub/PfuDl8bWMTT+cOgc1mYa8ZOjFSJ5kG8RT73vOBaQqaOoQ7ly6spHtseINsN2BvO7LPzbI5ZZq8NeTDlvRS+IMkJ6+DxeOOwC72X+gjuPCgfGz88gKmbwFm1AL9osSl0/Z7DnLXl9uaFxRSlVkMt/HzXQ3lcs5nPBkp4d0RNI9cenNipcLVI2e24lDUvIA59Rd3aznURdPUsDqdEFNYIZnxfObrdk8KoJxBZqiBzb5KH0oq8E89d5SqcC87uI8eZJXrP1UUnrYFRuef8pCw7Vz5UvR/hN5EWS7MXs2Kk9SdWa+fKHQLWYYH9SKBVfnQxuIqshKeI94CFgBT/LJXWELyxjavG5Tn3ALLmrBLZMwGTC6hfDF9hGSEpL2zi5/U80VCkklqv8Ym0QL+KeynmSbH0BOwl2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR21MB3033.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(10290500003)(110136005)(316002)(8676002)(186003)(508600001)(7696005)(9686003)(6506007)(71200400001)(26005)(53546011)(66556008)(64756008)(83380400001)(86362001)(5660300002)(52536014)(7416002)(8990500004)(33656002)(55016003)(2906002)(122000001)(38100700002)(82960400001)(82950400001)(921005)(66476007)(66446008)(8936002)(76116006)(38070700005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1lMZ0NMWnp3V2J5dDB3d1NwcXRJYkRWNndTbVA2dGxEL2Y2S0dRK0FxcCt0?=
 =?utf-8?B?UURYNzJhd3pLODFJWEtnbHBzd0lyZmxKNEc4cUlzRnFObmZXbW16eDhFVzdX?=
 =?utf-8?B?RHYyMElMT0ExQnRzWVZGWlQwdzRGQ1MyM2U2blNkQmx5SnhmRUhmRHN6UGFY?=
 =?utf-8?B?eUlEckNmR21OQmNxZENEaVhEUFVCT1Myc2tnbkdvQVUyeEtpSzByQmU1UVRG?=
 =?utf-8?B?WE1DYWJjVUhiSklDb2kydmpHdkFYTGs2UE1KK25qTEVVMFJ5YVhwRDRZUHVr?=
 =?utf-8?B?bGl4aFFSZUk3QlA0VjdYdm9Td0cyWlNpdDQ1aEt4WUo5aFZrMUlEYzBONEJS?=
 =?utf-8?B?d2JteHN4SDU4ZkJNYk9DMDZFS09qNFdBZGEwT1NYRjlZbUs2UnZHSzBTQmxI?=
 =?utf-8?B?eVFIeHAyeVBUM29oNVg1MzZoQlRZdW42Wm4wL0xyczRQUEVJU094L2JnZ2Ft?=
 =?utf-8?B?aWdQeEFsVmZnTGIwUXdtSFBQQ0J4ZzZ0U1VxN3NucGtzREJUUmgzQWMyYXY0?=
 =?utf-8?B?cEJCdGw2K3NGTEcyRlZQdzJMcnNzVi9uWFZ1WDdZMXExbkNIOVZ4aDJSY2Zj?=
 =?utf-8?B?VVJqTm9CdEZlaUxJTHVXMEYxMFRhTlovRTlvb21UN012M2UyMGdXVVNZT0hu?=
 =?utf-8?B?OUJkL2xjcDMrbzJrMno0MUZSaUtDNGkzSTFIakp2Q1pjdmQ4VXZuVHo1YzN2?=
 =?utf-8?B?Z3czRWxLYWxzdS9tS1Y2cTFGU0FPSjN2d0ZWNDRqTjRQamFjeDFnNzVGanRm?=
 =?utf-8?B?U3pib3diNVphYjF6N0NPVTlZUXV3SFJ4K0h4QW9OMmt2cDZvbTF2UU5WTi9B?=
 =?utf-8?B?NWt6aDVtUjlmK1ZyMXNrQjk2TUFKN1YxYjd4dmJHUzUzZm9FL05mb1dhOENX?=
 =?utf-8?B?R01XZm1NbHJUaUVnM2VVWlp5Umk0SGM3dktocGZ4SkZaOThxQnIxWjRXUldo?=
 =?utf-8?B?QXhUSjBzRTRmYmkxNzk2YWRQcWF6NlhWK1h5eW9VVU96ZkZ6d09UemV1T2NL?=
 =?utf-8?B?UEdZOVE0UHo5L1djV2Jpc2dMa1pNVzVnL3pJUDE1WlFRMklSaGVPQUVvZUpL?=
 =?utf-8?B?L1Y0V0tzRkZETFUxeEFNT0tTNDZmSEhvc1dJaktDamh6K2ZQTWlzV1NmcDJJ?=
 =?utf-8?B?dWVBRjY5UjdSSnYwUDA3Rm43eHBob3ZuL3pZdHpPVFA5QXI3V3BNL2VCK1FE?=
 =?utf-8?B?L1hzU1AvS09VV1lYaWR1UFNiY3Yxa1FvZU93WmxoNDhwa2puNnlkUXdHRmlj?=
 =?utf-8?B?Tm5pZHJxdFA4WTFOZFR2c0NQS2J0bzl2c0pnaE9KM2NjRTQyK1ZTMklJMnVq?=
 =?utf-8?B?MHl4Q0NHT3RrR3BJZTBGN3UxNFRhT1NFTkhrYnJIalpjaXVyeVdVL3dTay9n?=
 =?utf-8?B?bDJMM3FOSHN0Rzl4YkYwZExDTlUrOG9XK0VKUVBIUFV6Q3JkQlMxYmNYNHVz?=
 =?utf-8?B?UUl2clpWQis0L0YvZEtiM0YvTGc2MkoxbFFod05ranZuY0lhMlNpUVY0OHo4?=
 =?utf-8?B?WUdKMUdOZGVXSkZSelNVNUorWnZueSs3bXhoNndVOUZFdm5MNTZOSmJDaFpx?=
 =?utf-8?B?ejZUd2t6dUh1R2l2bmhoNmU0blkrZnk4Znh1bVRzOEd4bnQvQWxpVmF0TDVt?=
 =?utf-8?B?YmdhNHowTEQwZ3lhQ2JINDBkL1pSL1p4WnhpbmptQlBpdzlHbThSajFMQ3lE?=
 =?utf-8?B?ZEdNK2w1QWVvYnhhQ3hQdmhtNm9hNCtCYmJxTFQwUzlnUTFFSWlKZ2UxbW5R?=
 =?utf-8?B?Qk42c2FNeWxhdHpCbWhzZnluU3psWlpEZGFsK2UwNDZPWmRtdHl6enYvMUE4?=
 =?utf-8?B?TSsrS1FtZmZqZWlmMHQ1UmxiNllxZGdFbGFNRXdZZ2NOMDAzL0VJdVh3UVh0?=
 =?utf-8?B?RXFzUTR3ZmxjRXNyU2MxRXVXanJkTFhuZWVLSVlQMFd4a2pnbTE3cUdwYmZ5?=
 =?utf-8?B?YTRPSHNTV1p6MXlxNEdrRldJblZuRjV6SzBtd0NMaHg5QWdEYmEycUpQQUFW?=
 =?utf-8?B?Qjd5bmRUQU53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR21MB3033.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d6d12d-f775-4fc1-8e34-08da091f0983
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 20:36:53.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fl1xXNFqTRR51G5ATNmZrQUAPKjxB5NJ2Hh3jPSCC8pfo5TChi6xfjdrl3KydfcOxeRRuOGlTRfwyKTnjv5soSz/HB0pBQBtrXT4OdtNck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1206
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogRnJpZGF5LCBN
YXJjaCAxOCwgMjAyMiAzOjU4IEFNDQo+IA0KPiBPbiAyMDIyLTAzLTE4IDA1OjEyLCBNaWNoYWVs
IEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IEZyb206IFJvYmluIE11cnBoeSA8cm9iaW4ubXVy
cGh5QGFybS5jb20+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxNywgMjAyMg0KPiAxMDoxNSBBTQ0K
PiA+Pg0KPiA+PiBPbiAyMDIyLTAzLTE3IDE2OjI1LCBNaWNoYWVsIEtlbGxleSB2aWEgaW9tbXUg
d3JvdGU6DQo+ID4+PiBQQ0kgcGFzcy10aHJ1IGRldmljZXMgaW4gYSBIeXBlci1WIFZNIGFyZSBy
ZXByZXNlbnRlZCBhcyBhIFZNQnVzDQo+ID4+PiBkZXZpY2UgYW5kIGFzIGEgUENJIGRldmljZS4g
IFRoZSBjb2hlcmVuY2Ugb2YgdGhlIFZNYnVzIGRldmljZSBpcw0KPiA+Pj4gc2V0IGJhc2VkIG9u
IHRoZSBWTWJ1cyBub2RlIGluIEFDUEksIGJ1dCB0aGUgUENJIGRldmljZSBoYXMgbm8NCj4gPj4+
IEFDUEkgbm9kZSBhbmQgZGVmYXVsdHMgdG8gbm90IGhhcmR3YXJlIGNvaGVyZW50LiAgVGhpcyBy
ZXN1bHRzDQo+ID4+PiBpbiBleHRyYSBzb2Z0d2FyZSBjb2hlcmVuY2UgbWFuYWdlbWVudCBvdmVy
aGVhZCBvbiBBUk02NCB3aGVuDQo+ID4+PiBkZXZpY2VzIGFyZSBoYXJkd2FyZSBjb2hlcmVudC4N
Cj4gPj4+DQo+ID4+PiBGaXggdGhpcyBieSBwcm9wYWdhdGluZyB0aGUgY29oZXJlbmNlIG9mIHRo
ZSBWTWJ1cyBkZXZpY2UgdG8gdGhlDQo+ID4+PiBQQ0kgZGV2aWNlLiAgVGhlcmUncyBubyBlZmZl
Y3Qgb24geDg2L3g2NCB3aGVyZSBkZXZpY2VzIGFyZQ0KPiA+Pj4gYWx3YXlzIGhhcmR3YXJlIGNv
aGVyZW50Lg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2VsbGV5IDxtaWtl
bGxleUBtaWNyb3NvZnQuY29tPg0KPiA+Pj4gLS0tDQo+ID4+PiAgICBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaS1oeXBlcnYuYyB8IDE3ICsrKysrKysrKysrKystLS0tDQo+ID4+PiAgICAxIGZp
bGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlwZXJ2LmMgYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiA+Pj4gaW5kZXggYWUwYmMyZi4uMTQy
NzZmNSAxMDA2NDQNCj4gPj4+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpLWh5cGVy
di5jDQo+ID4+PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaS1oeXBlcnYuYw0KPiA+
Pj4gQEAgLTQ5LDYgKzQ5LDcgQEANCj4gPj4+ICAgICNpbmNsdWRlIDxsaW51eC9yZWZjb3VudC5o
Pg0KPiA+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2lycWRvbWFpbi5oPg0KPiA+Pj4gICAgI2luY2x1
ZGUgPGxpbnV4L2FjcGkuaD4NCj4gPj4+ICsjaW5jbHVkZSA8bGludXgvZG1hLW1hcC1vcHMuaD4N
Cj4gPj4+ICAgICNpbmNsdWRlIDxhc20vbXNoeXBlcnYuaD4NCj4gPj4+DQo+ID4+PiAgICAvKg0K
PiA+Pj4gQEAgLTIxNDIsOSArMjE0Myw5IEBAIHN0YXRpYyB2b2lkIGh2X3BjaV9yZW1vdmVfc2xv
dHMoc3RydWN0IGh2X3BjaWJ1c19kZXZpY2UNCj4gPj4gKmhidXMpDQo+ID4+PiAgICB9DQo+ID4+
Pg0KPiA+Pj4gICAgLyoNCj4gPj4+IC0gKiBTZXQgTlVNQSBub2RlIGZvciB0aGUgZGV2aWNlcyBv
biB0aGUgYnVzDQo+ID4+PiArICogU2V0IE5VTUEgbm9kZSBhbmQgRE1BIGNvaGVyZW5jZSBmb3Ig
dGhlIGRldmljZXMgb24gdGhlIGJ1cw0KPiA+Pj4gICAgICovDQo+ID4+PiAtc3RhdGljIHZvaWQg
aHZfcGNpX2Fzc2lnbl9udW1hX25vZGUoc3RydWN0IGh2X3BjaWJ1c19kZXZpY2UgKmhidXMpDQo+
ID4+PiArc3RhdGljIHZvaWQgaHZfcGNpX2Fzc2lnbl9wcm9wZXJ0aWVzKHN0cnVjdCBodl9wY2li
dXNfZGV2aWNlICpoYnVzKQ0KPiA+Pj4gICAgew0KPiA+Pj4gICAgCXN0cnVjdCBwY2lfZGV2ICpk
ZXY7DQo+ID4+PiAgICAJc3RydWN0IHBjaV9idXMgKmJ1cyA9IGhidXMtPmJyaWRnZS0+YnVzOw0K
PiA+Pj4gQEAgLTIxNjcsNiArMjE2OCwxNCBAQCBzdGF0aWMgdm9pZCBodl9wY2lfYXNzaWduX251
bWFfbm9kZShzdHJ1Y3QNCj4gPj4gaHZfcGNpYnVzX2RldmljZSAqaGJ1cykNCj4gPj4+ICAgIAkJ
CQkgICAgIG51bWFfbWFwX3RvX29ubGluZV9ub2RlKA0KPiA+Pj4gICAgCQkJCQkgICAgIGh2X2Rl
di0+ZGVzYy52aXJ0dWFsX251bWFfbm9kZSkpOw0KPiA+Pj4NCj4gPj4+ICsJCS8qDQo+ID4+PiAr
CQkgKiBPbiBBUk02NCwgcHJvcGFnYXRlIHRoZSBETUEgY29oZXJlbmNlIGZyb20gdGhlIFZNYnVz
IGRldmljZQ0KPiA+Pj4gKwkJICogdG8gdGhlIGNvcnJlc3BvbmRpbmcgUENJIGRldmljZS4gT24g
eDg2L3g2NCwgdGhlc2UgY2FsbHMNCj4gPj4+ICsJCSAqIGhhdmUgbm8gZWZmZWN0IGJlY2F1c2Ug
RE1BIGlzIGFsd2F5cyBoYXJkd2FyZSBjb2hlcmVudC4NCj4gPj4+ICsJCSAqLw0KPiA+Pj4gKwkJ
ZGV2X3NldF9kbWFfY29oZXJlbnQoJmRldi0+ZGV2LA0KPiA+Pj4gKwkJCWRldl9pc19kbWFfY29o
ZXJlbnQoJmhidXMtPmhkZXYtPmRldmljZSkpOw0KPiA+Pg0KPiA+PiBFd3cuLi4gaWYgeW91IHJl
YWxseSBoYXZlIHRvIGRvIHRoaXMsIEknZCBwcmVmZXIgdG8gc2VlIGEgcHJvcGVyDQo+ID4+IGh2
X2RtYV9jb25maWd1cmUoKSBoZWxwZXIgaW1wbGVtZW50ZWQgYW5kIHdpcmVkIHVwIHRvDQo+ID4+
IHBjaV9kbWFfY29uZmlndXJlKCkuIEFsdGhvdWdoIHNpbmNlIGl0J3MgYSBnZW5lcmljIHByb3Bl
cnR5IEkgZ3Vlc3MgYXQNCj4gPj4gd29yc3QgcGNpX2RtYV9jb25maWd1cmUgY291bGQgcGVyaGFw
cyBwcm9wYWdhdGUgY29oZXJlbmN5IGZyb20gdGhlIGhvc3QNCj4gPj4gYnJpZGdlIHRvIGl0cyBj
aGlsZHJlbiBieSBpdHNlbGYgaW4gdGhlIGFic2VuY2Ugb2YgYW55IG90aGVyIGZpcm13YXJlDQo+
ID4+IGluZm8uIEFuZCBpdCdzIGJ1aWx0LWluIHNvIGNvdWxkIHVzZSBhcmNoX3NldHVwX2RtYV9v
cHMoKSBsaWtlIGV2ZXJ5b25lDQo+ID4+IGVsc2UuDQo+ID4+DQo+ID4NCj4gPiBJJ20gbm90IHNl
ZWluZyBhbiBleGlzdGluZyBtZWNoYW5pc20gdG8gcHJvdmlkZSBhICJoZWxwZXIiIG9yIG92ZXJy
aWRlDQo+ID4gb2YgcGNpX2RtYV9jb25maWd1cmUoKS4gICBDb3VsZCB5b3UgZWxhYm9yYXRlPyAg
T3IgaXMgdGhpcyBzb21ldGhpbmcNCj4gPiB0aGF0IG5lZWRzIHRvIGJlIGNyZWF0ZWQ/DQo+IA0K
PiBJIG1lYW4gc29tZXRoaW5nIGxpa2UgdGhlIGRpZmYgYmVsb3cgKG90aGVyICNpbmNsdWRlcyBv
bWl0dGVkIGZvcg0KPiBjbGFyaXR5KS4gRXNzZW50aWFsbHkgaWYgVk1CdXMgaGFzIGl0cyBvd24g
d2F5IG9mIGRlc2NyaWJpbmcgcGFydHMgb2YNCj4gdGhlIHN5c3RlbSwgdGhlbiBmb3IgdGhvc2Ug
cGFydHMgaXQncyBuaWNlIGlmIGl0IGNvdWxkIGZpdCBpbnRvIHRoZSBzYW1lDQo+IGFic3RyYWN0
aW9ucyB3ZSB1c2UgZm9yIGZpcm13YXJlLWJhc2VkIHN5c3RlbSBkZXNjcmlwdGlvbi4NCg0KT0ss
IGdvdCBpdC4gIEFkZGluZyB0aGUgVk1idXMgc3BlY2lhbCBjYXNlIGludG8gcGNpX2RtYV9jb25m
aWd1cmUoKQ0Kd291bGQgd29yay4gIEJ1dCBhZnRlciBpbnZlc3RpZ2F0aW5nIGZ1cnRoZXIsIGxl
dCBtZSB0aHJvdyBvdXQgdHdvDQpvdGhlciBwb3NzaWJsZSBzb2x1dGlvbnMgYXMgd2VsbC4NCg0K
MSkgIEl0J3MgZWFzeSB0byBtYWtlIHRoZSB0b3AtbGV2ZWwgVk1idXMgbm9kZSBpbiB0aGUgRFNE
VCBiZQ0KdGhlIEFDUEkgY29tcGFuaW9uIGZvciB0aGUgcGNpX2hvc3QgYnJpZGdlLiAgVGhlIGZ1
bmN0aW9uDQpwY2liaW9zX3Jvb3RfYnJpZGdlX3ByZXBhcmUoKSB3aWxsIGRvIHRoaXMgaWYgdGhl
IHBjaS1oeXBlcnYuYw0KZHJpdmVyIHNldHMgc3lzZGF0YS0+cGFyZW50IHRvIHRoYXQgdG9wLWxl
dmVsIFZNYnVzIG5vZGUuICBUaGVuDQpwY2lfZG1hX2NvbmZpZ3VyZSgpd29ya3MgYXMgaXMuICBB
bHNvLCBjb21taXQgN2Q0MGMwZjcwIHRoYXQNCnNwZWNpYWwgY2FzZXMgcGNpYmlvc19yb290X2Jy
aWRnZV9wcmVwYXJlKCkgZm9yIEh5cGVyLVYgYmVjb21lcw0KdW5uZWNlc3NhcnkuICAgSSd2ZSBj
b2RlZCB0aGlzIGFwcHJvYWNoIGFuZCBpdCBzZWVtcyB0byB3b3JrLCBidXQNCkkgZG9uJ3Qga25v
dyBhbGwgdGhlIGltcGxpY2F0aW9ucyBvZiBtYWtpbmcgdGhhdCBWTWJ1cyBub2RlIGJlDQp0aGUg
QUNQSSBjb21wYW5pb24sIHBvdGVudGlhbGx5IGZvciBtdWx0aXBsZSBwY2lfaG9zdCBicmlkZ2Vz
Lg0KDQoyKSAgU2luY2UgdGhlcmUncyBubyB2SU9NTVUgYW5kIHdlIGRvbid0IGtub3cgaG93IGl0
IHdpbGwgYmUNCmRlc2NyaWJlZCBpZiB0aGVyZSBzaG91bGQgYmUgb25lIGluIHRoZSBmdXR1cmUs
IGl0J3MgYSBiaXQgcHJlbWF0dXJlDQp0byB0cnkgdG8gc2V0IHRoaW5ncyB1cCAiY29ycmVjdGx5
IiBub3cgdG8gaGFuZGxlIGl0LiAgQSBzaW1wbGUNCmFwcHJvYWNoIGlzIHRvIHNldCAgZG1hX2Rl
ZmF1bHRfY29oZXJlbnQgdG8gdHJ1ZSBpZiB0aGUgdG9wLWxldmVsDQpWTWJ1cyBub2RlIGluIHRo
ZSBEU0RUIGluZGljYXRlcyBjb2hlcmVudC4gIE5vIG90aGVyIGNoYW5nZXMgYXJlDQpuZWVkZWQu
ICBJZiB0aGVyZSdzIGEgdklPTU1VIGF0IHNvbWUgbGF0ZXIgdGltZSwgdGhlbiB3ZSBhZGQgdGhl
DQp1c2Ugb2YgYXJjaF9zZXR1cF9kbWFfb3BzKCkgZm9yIGVhY2ggZGV2aWNlLg0KDQpBbnkgdGhv
dWdodHMgb24gdGhlc2UgdHdvIGFwcHJvYWNoZXMgdnMuIGFkZGluZyB0aGUgVk1idXMNCnNwZWNp
YWwgY2FzZSBpbnRvIHBjaV9kbWFfY29uZmlndXJlKCk/ICBNeSBwcmVmZXJlbmNlIHdvdWxkIGJl
DQp0byBhdm9pZCBhZGRpbmcgdGhhdCBzcGVjaWFsIGNhc2UgaWYgb25lIG9mIHRoZSBvdGhlciB0
d28gYXBwcm9hY2hlcw0KaXMgcmVhc29uYWJsZS4NCg0KTWljaGFlbA0KDQo+IA0KPiBDaGVlcnMs
DQo+IFJvYmluLg0KPiANCj4gLS0tLS0+OC0tLS0tDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9wY2ktZHJpdmVyLmMgYi9kcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMNCj4gaW5kZXggNTg4NTg4
Y2ZkYTQ4Li43ZDkyY2NhZDE1NjkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL3BjaS1kcml2
ZXIuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9wY2ktZHJpdmVyLmMNCj4gQEAgLTIwLDYgKzIwLDcg
QEANCj4gICAjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4
L2FjcGkuaD4NCj4gICAjaW5jbHVkZSA8bGludXgvZG1hLW1hcC1vcHMuaD4NCj4gKyNpbmNsdWRl
IDxsaW51eC9oeXBlcnYuaD4NCj4gICAjaW5jbHVkZSAicGNpLmgiDQo+ICAgI2luY2x1ZGUgInBj
aWUvcG9ydGRydi5oIg0KPiANCj4gQEAgLTE2MDIsNiArMTYwMyw4IEBAIHN0YXRpYyBpbnQgcGNp
X2RtYV9jb25maWd1cmUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgIAkJc3RydWN0IGFjcGlfZGV2
aWNlICphZGV2ID0gdG9fYWNwaV9kZXZpY2Vfbm9kZShicmlkZ2UtPmZ3bm9kZSk7DQo+IA0KPiAg
IAkJcmV0ID0gYWNwaV9kbWFfY29uZmlndXJlKGRldiwgYWNwaV9nZXRfZG1hX2F0dHIoYWRldikp
Ow0KPiArCX0gZWxzZSBpZiAoaXNfdm1idXNfZGV2KGJyaWRnZSkpIHsNCj4gKwkJcmV0ID0gaHZf
ZG1hX2NvbmZpZ3VyZShkZXYsIGRldmljZV9nZXRfZG1hX2F0dHIoYnJpZGdlKSk7DQo+ICAgCX0N
Cj4gDQo+ICAgCXBjaV9wdXRfaG9zdF9icmlkZ2VfZGV2aWNlKGJyaWRnZSk7DQo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L2h5cGVydi5oIGIvaW5jbHVkZS9saW51eC9oeXBlcnYuaA0KPiBp
bmRleCBmNTY1YTg5Mzg4MzYuLmQxZDRkZDNkNWEzYSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9oeXBlcnYuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L2h5cGVydi5oDQo+IEBAIC0xNzY0
LDQgKzE3NjQsMTkgQEAgc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHZpcnRfdG9faHZwZm4o
dm9pZCAqYWRkcikNCj4gICAjZGVmaW5lIEhWUEZOX0RPV04oeCkJKCh4KSA+PiBIVl9IWVBfUEFH
RV9TSElGVCkNCj4gICAjZGVmaW5lIHBhZ2VfdG9faHZwZm4ocGFnZSkJKHBhZ2VfdG9fcGZuKHBh
Z2UpICoNCj4gTlJfSFZfSFlQX1BBR0VTX0lOX1BBR0UpDQo+IA0KPiArc3RhdGljIGlubGluZSBi
b29sIGlzX3ZtYnVzX2RldihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICt7DQo+ICsJLyoNCj4gKwkg
KiBkZXYtPmJ1cyA9PSAmaHZfYnVzIHdvdWxkIGJyZWFrIHdoZW4gdGhlIGNhbGxlciBpcyBidWls
dC1pbg0KPiArCSAqIGFuZCBDT05GSUdfSFlQRVJWPW0sIHNvIGxvb2sgZm9yIGl0IGJ5IG5hbWUg
aW5zdGVhZC4NCj4gKwkgKi8NCj4gKwlyZXR1cm4gIXN0cmNtcChkZXYtPmJ1cy0+bmFtZSwgInZt
YnVzIik7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgaW50IGh2X2RtYV9jb25maWd1cmUo
c3RydWN0IGRldmljZSAqZGV2LCBlbnVtDQo+IGRldl9kbWFfYXR0ciBhdHRyKQ0KPiArew0KPiAr
CWFyY2hfc2V0dXBfZG1hX29wcyhkZXYsIDAsIDAsIE5VTEwsIGF0dHIgPT0gREVWX0RNQV9DT0hF
UkVOVCk7DQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gICAjZW5kaWYgLyogX0hZUEVSVl9I
ICovDQo=
