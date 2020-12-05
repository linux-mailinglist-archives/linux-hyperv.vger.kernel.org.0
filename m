Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCF02CFF42
	for <lists+linux-hyperv@lfdr.de>; Sat,  5 Dec 2020 22:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgLEVen (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 5 Dec 2020 16:34:43 -0500
Received: from mail-dm6nam12on2090.outbound.protection.outlook.com ([40.107.243.90]:35233
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbgLEVem (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 5 Dec 2020 16:34:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qb+cSQtX9rT/9BhM6wKN1DD2Fgq/HYil1euBPdyJOpH8k7pxRSp4+nucypuC2QN6NX4F9ktZcXlt7yA3nlqCLnSjBDLAB4tJ34z7idM/mbPAk1/iPVQuuPe2WmTxLaRT9VI4FZXoiw6TBCKgBuj6h8UIenKwHwN7jaAmIdMAPE4o6LwjbKMxl7+pfMXyudqb5UMSOONUgh0TpNEjKy2h5kCwamy/JIOPYIe+bP+EBgHg8/ZhrKmn6RJk9/l7l28K8PXY2au8EupGnaG0FhScvbpphaiPyb4AYg9AYJDVe95vbSjALuxDn8EIGHzLHaQJ6z+Wr6tYl1QKv1+W274vBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FC+dFl84KPJ9GidFDWICQhSoqoSaZEImrOHkWYvXfI=;
 b=A1XaweCAJoktYlwLEJ0JhzVvFlXWxUi84NDEFs5Fna7uoNNShBxB9iDVY516fEF9fqjQodKYu/pAE2jlrZisTz4ng4++HCnkwsE8pm289oHc8IQHm1/90NYwHsoTajCCyCRXDh42gi1fB+e6qqcuDsmv+je8Dq2fOTIX+hbQ0TRzhv6WyWH74CcPJIc+Ha1QLqekA3u2MrAPKkvJzYb50OlVck7DcMPJ43arBSajw+CDbeINOkBs8i7SwwIIctIbwBGtw0a9IXOIKGk9q7Y6wXbTYfwyVBW2vCnPOmBfYWUtF+D2xBiHzHVZuGIVj7L1dPxT3Yo1zVrzym9iS7i7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FC+dFl84KPJ9GidFDWICQhSoqoSaZEImrOHkWYvXfI=;
 b=ROEC+61CsIN7fTk3Tw2mOk8y/tM0713fTtf6I9Mka1cFTE0mdYne95dYylTwAkpENfexO7Hx0U7pX1Wb1pVshm8K0EYVqiyFKY/eySAHpxqvqokq+bcyj1I6diDnjE6QMu58nigk9paEt0jqyMMyDkd733ikwI9HaF8GygAecMg=
Received: from (2603:10b6:302:a::16) by
 MW2PR2101MB1033.namprd21.prod.outlook.com (2603:10b6:302:4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.7; Sat, 5 Dec
 2020 21:33:53 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3654.005; Sat, 5 Dec 2020
 21:33:53 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Max Stolze <max.stolze@fau.de>,
        Stefan Eschenbacher <stefan.eschenbacher@fau.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel@i4.cs.fau.de" <linux-kernel@i4.cs.fau.de>
Subject: RE: [PATCH 0/3] drivers/hv: make max_num_channels_supported
 configurable
Thread-Topic: [PATCH 0/3] drivers/hv: make max_num_channels_supported
 configurable
Thread-Index: AQHWyy4HqEchZIoy5kOEspja/IM9V6nozdYggAAnOICAABAawA==
Date:   Sat, 5 Dec 2020 21:33:52 +0000
Message-ID: <MW2PR2101MB1052B86A1C6C9A64E8DDBA6ED7F01@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201205172650.2290-1-stefan.eschenbacher@fau.de>
 <MW2PR2101MB1052DC9416ABC1ECFE25E38DD7F01@MW2PR2101MB1052.namprd21.prod.outlook.com>
 <1b2e2fce-7dd5-9ca2-840e-2c48ed087bc6@fau.de>
In-Reply-To: <1b2e2fce-7dd5-9ca2-840e-2c48ed087bc6@fau.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-05T21:33:51Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d7a524d8-7b44-4980-9ede-8953d25962ec;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: fau.de; dkim=none (message not signed)
 header.d=none;fau.de; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eb852398-46d9-46ed-afef-08d899657673
x-ms-traffictypediagnostic: MW2PR2101MB1033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB1033B77E0ACCD4C3E2BCCFD7D7F01@MW2PR2101MB1033.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DAd8c24zwWBc4A4jPru+XTPUby9jz40JCbMsTAvp+6GSPtA7qXfRNLDpCLUEUWL11n+GL3mKXE5gu3RHS8sFs2dOFwvOI0YKVCEbk3xkoCNazgIlmT3VTsmEQBU78kFGy1y09GrbF4gRr+j3IJneqax54WMwPo3skdM+S3xkKBiHDkZXJ0kw+iv7KnvzFP1egTRN8bVv1kyR8X5SazRSTphbHvrtUGEO2klZbacP5pb17X2lO6fiWuaN9evEzbwqCVIk4XymQGJ3jah9Ds4BP0oJ3qugO4dJXqbY4DHZoPMUNZJoIXu5bbQcLKkFSxa3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(8990500004)(86362001)(82960400001)(82950400001)(83380400001)(4326008)(76116006)(33656002)(110136005)(10290500003)(66476007)(64756008)(66556008)(316002)(26005)(9686003)(55016002)(8936002)(6506007)(52536014)(53546011)(8676002)(2906002)(66946007)(5660300002)(66446008)(7696005)(186003)(54906003)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?SWZibW40ajlCOXBPNHovNmFlckg1cjR3Y29VUGRod1NDNmtyTEhvS1U5cjVX?=
 =?utf-8?B?b2VEZ3hZbmNkZ09pdWJhRXhsazZENlVDYWgveUlBRFBGWVp2SFJSbmdOdzZo?=
 =?utf-8?B?Si9sRjd5YituUGNRbFhEYmZGWjk2a3hsVUhiWXlsaHU2bGxyMlJ3ckFGY0tV?=
 =?utf-8?B?eFFRNjRJVWQ3T09VMkZEVGlLdk9LTVNlOVVBNGVjQkRCYUVZSllXSWNjUnEv?=
 =?utf-8?B?MEt2RnZKcDNwejE2bC9FQitVOFhua1BHZ0pVOEhCN1NrU3lCR3p3SnZ6OFJU?=
 =?utf-8?B?eWs5OHZlSUdLM2ljNkF4U2lpc05qbWRvMUlRZGlQTzkwcDJhWC9qMFl1bVE3?=
 =?utf-8?B?T3k3c1hyaktVL2JmRXBYQ0k0QUsrRmpYREExR3UrYlNESUZsQmJBTld5NFo5?=
 =?utf-8?B?N2pmaEMvMmRLYlY4M1JDY0FRQjlVZ1pUQU9MK0V2aHpLa3g5MkZURmIyMWdx?=
 =?utf-8?B?NkhseGFGL2MwOGlkcVRSQk54VW1PL0lXeEUwaVlrbk9qNCsrRDJza1NmUnV0?=
 =?utf-8?B?VlZVaUYwY21WWjZXMDFtQUFwNGt4NnQ2bGRuTURXOGdUM2RHVE9lQ2JySmRO?=
 =?utf-8?B?eEx2TmRsMitiZU1mTVQyM0E2RlFIeE1SYTRJVUltQzBQTHpIbTNZRDMxa2x4?=
 =?utf-8?B?OTB1MzZyaFNsU0JWQVZMUVFLMHNNM3U2SlV4T2JtUlI4SzZVQnZadkJCSDJR?=
 =?utf-8?B?clRjNkdTRk9xek5hVVd0RVBqalJpcm01aFJhQXA4TEVuZmRselZHVWpqZGZ0?=
 =?utf-8?B?aWF6d1Y3Y3JHY0RPNXR6MU5Xb2hEazl6L1FMcTQzdVN0TW9EbDZZRmRDV3dL?=
 =?utf-8?B?dGdNR0psMWEyeU0zL1hZTmt6S0xFS2hITng0cjJpMHFNSjg3bVNVbWNuSEZ5?=
 =?utf-8?B?SEtFZ2pqNHRHUldEWHd0elBnNUs0YU04R1ljKzdGdEpHNWRaSmh6cVlOTmVH?=
 =?utf-8?B?cGJNakdBT0UwZUdhSWp4eVZYazQyT1hBUU00TWJVRk10a2NZYWxKOCtNQVBy?=
 =?utf-8?B?cmRIbithVUxxSHRqYUYrenFEZ0JUTFhHRUFHNDVXYTNQOTBiaUJiYWsxdy80?=
 =?utf-8?B?WWFDWWZqTmtRcnRNc0JucDRjaTBDZlRDVjd4OXNCN25WS09kSE5FMHZBcmRV?=
 =?utf-8?B?U3NZNXdtUDFKeHNUWXdvZm10TTdWdWRjNnpLWjg0L3RYaC9mOC9Mc2ZVMVow?=
 =?utf-8?B?YTNiRC9QODFNSTY0SWtFMHhBTnVJZ3BQT3lwQ3IyaHV3b2lwMEtydEtxYnY4?=
 =?utf-8?B?NWpJYmFkN0pMbjFldDdxRGZuKzBscEtFdGhLckFMUzVZSVdDdnV2V3BKSnlJ?=
 =?utf-8?Q?mgftT6OdwNveU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb852398-46d9-46ed-afef-08d899657673
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2020 21:33:52.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h7BFesUHeANWV50doJSTOcXtG8iCkNZySqa7viRbcjjfZnErexlVyTxBeECl95sB2wrG8dk+YkcDE6OfPlbGfPYAyZvVlHstloFeI3reeUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1033
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTWF4IFN0b2x6ZSA8bWF4LnN0b2x6ZUBmYXUuZGU+IFNlbnQ6IFNhdHVyZGF5LCBEZWNl
bWJlciA1LCAyMDIwIDEyOjMyIFBNDQo+IA0KPiBPbiAwNS8xMi8yMDIwIDE5OjI3LCBNaWNoYWVs
IEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBTdGVmYW4gRXNjaGVuYmFjaGVyIDxzdGVmYW4uZXNj
aGVuYmFjaGVyQGZhdS5kZT4NCj4gPj4NCj4gPj4gQWNjb3JkaW5nIHRvIHRoZSBUT0RPIGNvbW1l
bnQgaW4gaHlwZXJ2X3ZtYnVzLmggdGhlIHZhbHVlIGluIG1hY3JvDQo+ID4+IE1BWF9OVU1fQ0hB
Tk5FTFNfU1VQUE9SVEVEIHNob3VsZCBiZSBjb25maWd1cmFibGUuIFRoZSBmaXJzdCBwYXRjaA0K
PiA+PiBhY2NvbXBsaXNoZXMgdGhhdCBieSBpbnRyb2R1Y3RpbmcgdWludCBtYXhfbnVtX2NoYW5u
ZWxzX3N1cHBvcnRlZCBhcw0KPiA+PiBtb2R1bGUgcGFyYW1ldGVyLg0KPiA+PiBBbHNvIG1hY3Jv
IE1BWF9OVU1fQ0hBTk5FTFNfU1VQUE9SVEVEX0RFRkFVTFQgaXMgaW50cm9kdWNlZCB3aXRoDQo+
ID4+IHZhbHVlIDI1Niwgd2hpY2ggaXMgdGhlIGN1cnJlbnRseSB1c2VkIG1hY3JvIHZhbHVlLg0K
PiA+PiBNQVhfTlVNX0NIQU5ORUxTX1NVUFBPUlRFRCB3YXMgZm91bmQgYW5kIHJlcGxhY2VkIGlu
IHR3byBsb2NhdGlvbnMuDQo+ID4+DQo+ID4+IER1cmluZyBtb2R1bGUgaW5pdGlhbGl6YXRpb24g
c2FuaXR5IGNoZWNrcyBhcmUgYXBwbGllZCB3aGljaCB3aWxsIHJlc3VsdA0KPiA+PiBpbiBFSU5W
QUwgb3IgRVJBTkdFIGlmIHRoZSBnaXZlbiB2YWx1ZSBpcyBubyBtdWx0aXBsZSBvZiAzMiBvciBs
YXJnZXIgdGhhbg0KPiA+PiBNQVhfTlVNX0NIQU5ORUxTLg0KPiA+Pg0KPiA+PiBXaGlsZSB0ZXN0
aW5nLCB3ZSBmb3VuZCBhIG1pc2xlYWRpbmcgdHlwbyBpbiB0aGUgY29tbWVudCBmb3IgdGhlIG1h
Y3JvDQo+ID4+IE1BWF9OVU1fQ0hBTk5FTFMgd2hpY2ggaXMgZml4ZWQgYnkgdGhlIHNlY29uZCBw
YXRjaC4NCj4gPj4NCj4gPj4gVGhlIHRoaXJkIHBhdGNoIG1ha2VzIHRoZSBhZGRlZCBkZWZhdWx0
IG1hY3JvIGNvbmZpZ3VyYWJsZSBieQ0KPiA+PiBpbnRyb2R1Y3Rpb24gYW5kIHVzZSBvZiBLY29u
ZmlnIHBhcmFtZXRlciBIWVBFUlZfVk1CVVNfREVGQVVMVF9DSEFOTkVMUy4NCj4gPj4gRGVmYXVs
dCB2YWx1ZSByZW1haW5zIGF0IDI1Ni4NCj4gPj4NCj4gPj4gVHdvIG5vdGVzIG9uIHRoZXNlIHBh
dGNoZXM6DQo+ID4+IDEpIFdpdGggYWJvdmUgcGF0Y2hlcyBpdCBpcyB2YWxpZCB0byBjb25maWd1
cmUgbWF4X251bV9jaGFubmVsc19zdXBwb3J0ZWQNCj4gPj4gYW5kIE1BWF9OVU1fQ0hBTk5FTFNf
U1VQUE9SVEVEX0RFRkFVTFQgYXMgMC4gV2Ugc2ltcGx5IGRvbid0IGtub3cgaWYgdGhhdA0KPiA+
PiBpcyBhIHZhbGlkIHZhbHVlLiBEb2luZyBzbyB3aGlsZSB0ZXN0aW5nIHN0aWxsIGxlZnQgdXMg
d2l0aCBhIHdvcmtpbmcNCj4gPj4gRGViaWFuIFZNIGluIEh5cGVyLVYgb24gV2luZG93cyAxMC4N
Cj4gPj4gMikgVG8gc2V0IHRoZSBLY29uZmlnIHBhcmFtZXRlciB0aGUgdXNlciBjdXJyZW50bHkg
aGFzIHRvIGRpdmlkZSB0aGUNCj4gPj4gZGVzaXJlZCBkZWZhdWx0IG51bWJlciBvZiBjaGFubmVs
cyBieSAzMiBhbmQgZW50ZXIgdGhlIHJlc3VsdCBvZiB0aGF0DQo+ID4+IGNhbGN1bGF0aW9uLiBU
aGlzIHdheSBib3RoIGtub3duIGNvbnN0cmFpbnRzIHdlIGdvdCBmcm9tIHRoZSBjb21tZW50cyBp
bg0KPiA+PiB0aGUgY29kZSBhcmUgZW5mb3JjZWQuIEl0IGZlZWxzIGEgYml0IHVuaW50dWl0aXZl
IHRob3VnaC4gV2UgaGF2ZW4ndCBmb3VuZA0KPiA+PiBLY29uZmlnIG9wdGlvbnMgdG8gZW5zdXJl
IHRoYXQgdGhlIHZhbHVlIGlzIGEgbXVsdGlwbGUgb2YgMzIuIFNvIGlmIHlvdSdkDQo+ID4+IGxp
a2UgdXMgdG8gZml4IHRoYXQgd2UnZCBiZSBoYXBweSBmb3Igc29tZSBpbnB1dCBvbiBob3cgdG8g
c2V0dGxlIGl0IHdpdGgNCj4gPj4gS2NvbmZpZy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
U3RlZmFuIEVzY2hlbmJhY2hlciA8c3RlZmFuLmVzY2hlbmJhY2hlckBmYXUuZGU+DQo+ID4+IENv
LWRldmVsb3BlZC1ieTogTWF4IFN0b2x6ZSA8bWF4LnN0b2x6ZUBmYXUuZGU+DQo+ID4+IFNpZ25l
ZC1vZmYtYnk6IE1heCBTdG9semUgPG1heC5zdG9semVAZmF1LmRlPg0KPiA+Pg0KPiA+PiBTdGVm
YW4gRXNjaGVuYmFjaGVyICgzKToNCj4gPj4gICBkcml2ZXJzL2h2OiBtYWtlIG1heF9udW1fY2hh
bm5lbHNfc3VwcG9ydGVkIGNvbmZpZ3VyYWJsZQ0KPiA+PiAgIGRyaXZlcnMvaHY6IGZpeCBtaXNs
ZWFkaW5nIHR5cG8gaW4gY29tbWVudA0KPiA+PiAgIGRyaXZlcnMvaHY6IGFkZCBkZWZhdWx0IG51
bWJlciBvZiB2bWJ1cyBjaGFubmVscyB0byBLY29uZmlnDQo+ID4+DQo+ID4+ICBkcml2ZXJzL2h2
L0tjb25maWcgICAgICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+PiAgZHJpdmVycy9odi9oeXBl
cnZfdm1idXMuaCB8ICA4ICsrKystLS0tDQo+ID4+ICBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5jICAg
IHwgMjAgKysrKysrKysrKysrKysrKysrKy0NCj4gPj4gIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5z
ZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPj4NCj4gPj4gLS0NCj4gPj4gMi4yMC4xDQo+
ID4NCj4gPiBTdGVmYW4gLS0gdGhpcyBjb3ZlciBsZXR0ZXIgZW1haWwgY2FtZSB0aHJvdWdoLCBi
dXQgaXQgZG9lc24ndCBsb29rIGxpa2UNCj4gPiB0aGUgaW5kaXZpZHVhbCBwYXRjaCBlbWFpbHMg
ZGlkLiAgU28geW91IG1pZ2h0IHdhbnQgdG8gY2hlY2sgeW91cg0KPiA+IHBhdGNoIHNlbmRpbmcg
cHJvY2Vzcy4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBpbnRlcmVzdCBpbiB0aGlzIG9sZCAi
VE9ETyIgaXRlbS4gIEJ1dCBsZXQgbWUgcHJvdmlkZSBzb21lDQo+ID4gYWRkaXRpb25hbCBiYWNr
Z3JvdW5kLiAgU3RhcnRpbmcgaW4gV2luZG93cyA4IGFuZCBXaW5kb3dzIFNlcnZlciAyMDEyLA0K
PiA+IEh5cGVyLVYgcmV2aXNlZCB0aGUgbWVjaGFuaXNtIGJ5IHdoaWNoIGNoYW5uZWwgaW50ZXJy
dXB0IG5vdGlmaWNhdGlvbnMNCj4gPiBhcmUgbWFkZS4gIFRoZSBNQVhfTlVNX0NIQU5ORUxTX1NV
UFBPUlRFRCB2YWx1ZSBpcyBvbmx5IHVzZWQNCj4gPiB3aXRoIFdpbmRvd3MgNyBhbmQgV2luZG93
cyBTZXJ2ZXIgMjAwOCBSMiwgbmVpdGhlciBvZiB3aGljaCBpcyBvZmZpY2lhbGx5DQo+ID4gc3Vw
cG9ydGVkIGFueSBsb25nZXIuICBTZWUgdGhlIGNvZGUgYXQgdGhlIHRvcCBvZiB2bWJ1c19jaGFu
X3NjaGVkKCkgd2hlcmUNCj4gPiB0aGUgVk1CdXMgcHJvdG9jb2wgdmVyc2lvbiBpcyBjaGVja2Vk
LCBhbmQgTUFYX05VTV9DSEFOTkVMU19TVVBQT1JURUQNCj4gPiBpcyB1c2VkIG9ubHkgd2hlbiB0
aGUgcHJvdG9jb2wgdmVyc2lvbiBpbmRpY2F0ZXMgd2UncmUgcnVubmluZyBvbiBXaW5kb3dzIDcN
Cj4gPiAob3IgdGhlIGVxdWl2YWxlbnQgV2luZG93cyBTZXJ2ZXIgMjAwOCBSMikuDQo+ID4NCj4g
PiBCZWNhdXNlIHRoZSBvbGQgbWVjaGFuaXNtIHdhcyBzdXBlcnNlZGVkLCBtYWtpbmcgdGhlIHZh
bHVlIGNvbmZpZ3VyYWJsZQ0KPiA+IGRvZXNuJ3QgaGF2ZSBhbnkgYmVuZWZpdC4gICBBdCBzb21l
IHBvaW50LCB3ZSB3aWxsIHJlbW92ZSB0aGlzIG9sZCBjb2RlIHBhdGgNCj4gPiBlbnRpcmVseSwg
aW5jbHVkaW5nIHRoZSAjZGVmaW5lIE1BWF9OVU1fQ0hBTk5FTFNfU1VQUE9SVEVELiAgVGhlDQo+
ID4gY29tbWVudCB3aXRoIHRoZSAiVE9ETyIgY291bGQgYmUgcmVtb3ZlZCwgYnV0IG90aGVyIHRo
YW4gdGhhdCwgSSBkb24ndA0KPiA+IHRoaW5rIHdlIHdhbnQgdG8gbWFrZSB0aGVzZSBjaGFuZ2Vz
Lg0KPiA+DQo+ID4gTWljaGFlbA0KPiA+DQo+IA0KPiBIaSBNaWNoYWVsLA0KPiB0aGFua3MgZm9y
IHRoZSBpbnNpZ2h0IGFuZCBleHBsYW5hdGlvbi4NCj4gSXQncyBhIHBpdHkgdGhhdCB0aGUgcmVz
dCBvZiB0aGUgc2VyaWVzIGRpZCBub3QgbWFrZSBpdCB0cm91Z2guDQo+IEhvd2V2ZXIsIGdpdmVu
IHdoYXQgeW91IHdyb3RlIGl0IGRvZXNuJ3Qgc2VlbSB0byBiZSBvZg0KPiB1dG1vc3QgaW1wb3J0
YW5jZS4NCj4gDQo+IEFzIGlycmVsZXZhbnQgYXMgaXQgbWF5IGJlIHdlJ2Qgc3RpbGwgYmUgZ2xh
ZCB0byBzZWUgdGhlIFRPRE8gZ29uZS4NCj4gR2l2ZW4gdGhhdCB3ZSBmb3VuZCBpdCBieSBsb29r
aW5nIGZvciB0aGluZ3MgdGhhdCBjYW4gYmUgZG9uZSBhcm91bmQNCj4gdGhlIGtlcm5lbCBJIGRv
bid0IHNlZSB3aHkgc29tZWJvZHkgZWxzZSB3b3VsZCBub3QgZmluZCBpdCB3aGlsZSBsb29raW5n
DQo+IGZvciB0aGUgc2FtZS4NCj4gDQo+IE1heA0KDQpUaGUgYWRkaXRpb25hbCBwYXRjaGVzIGRp
ZCBmaW5hbGx5IHNob3cgdXAgLS0gYWJvdXQgNDUgbWludXRlcyBsYXRlci4gIFRoZSBzYW1lDQpk
ZWxheSBvY2N1cnJlZCBpbiB0aGUgcGF0Y2hlcyBhcHBlYXJpbmcgb24gbGttbC5vcmcsIHNvIHRo
ZXJlIG11c3QgYmUgaGF2ZQ0KYmVlbiBzb21lIGRlbGF5IG9uIHRoZSBzZW5kaW5nIHNpZGUuICBO
byBtYXR0ZXIuDQoNCkkgd291bGQgYmUgZmluZSBpZiB5b3Ugd2FudCB0byBzdWJtaXQgYSBwYXRj
aCB0aGF0IHJlbW92ZXMgdGhlICJUT0RPIiBhbmQNCmZpeGVzIHRoZSAxNjM0OCB2cy4gMTYzODQg
dHlwbyBpbiB0aGUgY29tbWVudCBmb3IgTUFYX05VTV9DSEFOTkVMUy4NCg0KTWljaGFlbA0KDQoN
Cg==
