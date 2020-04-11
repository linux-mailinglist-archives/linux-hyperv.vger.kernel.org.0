Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5EE1A4E4C
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Apr 2020 08:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgDKGCF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 11 Apr 2020 02:02:05 -0400
Received: from mail-eopbgr1310131.outbound.protection.outlook.com ([40.107.131.131]:52096
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbgDKGCF (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 11 Apr 2020 02:02:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGnlkc0+AO19PXLt0V4NtfA7mVqJj1NR7IJuTtHLOvmYK94bkcHj+7CE/DIEjKUR5Vxcg2UcevVr++81brcXAM0++uIzzVXni2dxJVsaVsvdOLsMqYPys5I7UiDtEqlb8uYVY8jr2CZUJ3oelNUU4OOYv6ZAQkzZoBNcBJhaXymV2FVusrF1k7bkdgGUdq17OE8LWJOz3hfkXWlJcVoIuy9beMUPTH0gqiQvxgaAmSiuztxe75iEE3QkPb5x7rKNtXX81/P6VIYt/QxLjSb9EvcKcJtivlLsGPFtifdR8UfKFzS8IM38L02igZqdmiKAtcNuVLP7vUKv4BxObcNGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=543GNL0hoCuIPGcbBtCD045F3WVF8wglkq3shAu4SZ0=;
 b=Yt3FzcUJfm0b31Sxir/JtmHSULpBQinQAVFGBSxDy5e5aSc1Np/W7pHk5k0skP73C1919K44ippt4aQEYQxj7r2yBfJsb0oxi17Rhb5gtNnwbD3PNQ1nbnJY/ODPH3jvwFxZmRLBhDlOVQqpU5ff9uqSVipwn8/Bk1lmnhzSv+VmjMSG3WYCXUkw2vlb6gvVOSQsvrWVr92Oswt+L0NzHXY7ATOWMplwd4SXs58SDWNITi94bCp7CBlLYqI2KZCywOQJtM4doozJOcE0C7NjHpS5UAjANhlCwYtOEfxZW04SWjY0Tw3rYUiR029jsdz0ycqScAl/7Exlbg3fo3iPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=543GNL0hoCuIPGcbBtCD045F3WVF8wglkq3shAu4SZ0=;
 b=D9v/giNPr1vSn9dbEL4Ze9yKLdfRIcBT8XUjkaB4+5gTJgD4GeGZZapDXevd2zrRQcfFyYLzbJf76DsfruzWYl4V/MDrb+07p8JdwhDFcf0HAxyM6Kcf8fJCHAwtmf2Sv3Ns3358xJoKMuy9q17dNZUBwj+87Q2DTVBYf5CXAI4=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (52.132.236.76) by
 HK0P153MB0274.APCP153.PROD.OUTLOOK.COM (52.132.236.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.3; Sat, 11 Apr 2020 06:01:41 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2921.020; Sat, 11 Apr 2020
 06:01:41 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Ming Lei <tom.leiming@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Long Li <longli@microsoft.com>, vkuznets <vkuznets@redhat.com>,
        Michael Kelley <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Olaf Hering <olaf@aepfle.de>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: SCSI low level driver: how to prevent I/O upon hibernation?
Thread-Topic: SCSI low level driver: how to prevent I/O upon hibernation?
Thread-Index: AdYO+lVJkAFfrToQQYmccjddvm2wiwAEVA6AAC5hOXA=
Date:   Sat, 11 Apr 2020 06:01:39 +0000
Message-ID: <HK0P153MB027320771C7A000B85BF3B97BFDF0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <HK0P153MB0273A1B109CE3A33F0984D34BFDE0@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <CACVXFVO5Ni531JO+62CW4pV2y6gT98_8G=jiCJCZoqjkUBmo9Q@mail.gmail.com>
In-Reply-To: <CACVXFVO5Ni531JO+62CW4pV2y6gT98_8G=jiCJCZoqjkUBmo9Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-11T06:01:35.5568683Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=99c19a2c-bb67-431b-9e76-2dd7d8e36774;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:50a1:820f:4f92:d9bb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01e553e4-9f3b-4ed1-f419-08d7ddddce3d
x-ms-traffictypediagnostic: HK0P153MB0274:|HK0P153MB0274:|HK0P153MB0274:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <HK0P153MB0274819DA46D5C2C1CDABA86BFDF0@HK0P153MB0274.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03706074BC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(346002)(396003)(136003)(39860400002)(366004)(8990500004)(7696005)(4326008)(81156014)(9686003)(71200400001)(54906003)(316002)(478600001)(33656002)(55016002)(10290500003)(186003)(2906002)(66946007)(6506007)(53546011)(8936002)(66446008)(64756008)(66556008)(66476007)(86362001)(76116006)(5660300002)(52536014)(110136005)(82960400001)(82950400001)(8676002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ta/3+ihBIccYzZSObCSi1OEUfUXMHoi2lNECuv8387YrLr7CEgSGYGBga3oWrn8i5iB2AU265XLFCCIERfpg2p69xveFj4vkk7NCiR2lj69QuqgoMSzUL5Z6LaObvaPhTxr0/1tFlRY1yD8S/9z3AiLO/+Ul3rhVuuQlaUaiYRIXbiXESipkIBZ8HVlGSXNNKs5+CfVAHOPbWQJl6bqswGNK+PVoZ5VUP3PKejnBH3ed+lYJmoAMx8vdAgeOrbPVM/rZQSIVlme4tFM04yLh3p1nj3A/dG4guVwljvZxNZxqF2ZWw8m9okZMBwSqVRFizMmKnTRPEEq7Ui8KKALJNie2sG4Y/+XC620Sq01bPiZI7A96DcdL4uEY5zwpNShMcZMgqpeKUv8XLi00p6CAnPOyNBl7VsoAv38Es0HgI5zoQwek+5ugHZHoa2Gvp5+L
x-ms-exchange-antispam-messagedata: gLucx4OAZeso+UorOiIxF9pstBk6ELJ+1Y63euUOdj/t+W/NcbKBfo6VW12mdWJ37xdRCStMgKOmXimooLOAHf3v4CIbh9hC2wnclBX4r0pmuBvopA807KftbyhGCUylYEQf6ypQ3SQjGkmEz9ghFdmY32241uA91zMs3bNvnIHZS03Gt6f0ZieVzfoYJvN57vs+hxeeh8FZQ6yNpgQfRg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e553e4-9f3b-4ed1-f419-08d7ddddce3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2020 06:01:39.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLBDfD7hn/EiOgIyQLphxCEw9YJ9F+YSU6GhI2d/5ZhgplXsFIsp1z7Dv8osYfzRkt+5hqYhMbhlhaFFXqVrKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0274
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBNaW5nIExlaSA8dG9tLmxlaW1pbmdAZ21haWwuY29tPg0KPiBTZW50OiBGcmlkYXks
IEFwcmlsIDEwLCAyMDIwIDEyOjQzIEFNDQo+IFRvOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3Nv
ZnQuY29tPg0KPiANCj4gSGVsbG8gRGV4dWFuLA0KPiANCj4gT24gRnJpLCBBcHIgMTAsIDIwMjAg
YXQgMTo0NCBQTSBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPiB3cm90ZToNCj4gPg0K
PiA+IEhpIGFsbCwNCj4gPiBDYW4geW91IHBsZWFzZSByZWNvbW1lbmQgdGhlIHN0YW5kYXJkIHdh
eSB0byBwcmV2ZW50IHRoZSB1cHBlciBsYXllciBTQ1NJDQo+ID4gZHJpdmVyIGZyb20gc3VibWl0
dGluZyBuZXcgSS9PIHJlcXVlc3RzIHdoZW4gdGhlIHN5c3RlbSBpcyBkb2luZw0KPiA+IGhpYmVy
bmF0aW9uPw0KPiA+DQo+ID4gQWN0dWFsbHkgSSBhbHJlYWR5IGFza2VkIHRoZSBxdWVzdGlvbiBv
biA1LzMwIGxhc3QgeWVhciAuLi4NCj4gPiBhbmQgSSB0aG91Z2h0IGFsbCB0aGUgc2RldnMgYXJl
IHN1c3BlbmRlZCBhbmQgcmVzdW1lZCBhdXRvbWF0aWNhbGx5IGluDQo+ID4gZHJpdmVycy9zY3Np
L3Njc2lfcG0uYywgYW5kIHRoZSBsb3cgbGV2ZWwgU0NTSSBhZGFwdGVyIGRyaXZlciAoaS5lLiBo
dl9zdG9ydnNjKQ0KPiA+IG9ubHkgbmVlZHMgdG8gc3VzcGVuZC9yZXN1bWUgdGhlIHN0YXRlIG9m
IHRoZSBhZGFwdGVyIGl0c2VsZi4gSG93ZXZlciwgaXQNCj4gPiBsb29rcw0KPiA+IHRoaXMgaXMg
bm90IHRydWUsIGJlY2F1c2UgdG9kYXkgSSBnb3Qgc3VjaCBhIHBhbmljIGluIGEgdjUuNiBMaW51
eCBWTSBydW5uaW5nDQo+ID4gb24gSHlwZXItVjogdGhlICdzdXNwZW5kJyBwYXJ0IG9mIHRoZSBo
aWJlcm5hdGlvbiBwcm9jZXNzIGZpbmlzaGVkIHdpdGhvdXQgDQo+ID4gYW55IGlzc3VlLCBidXQg
d2hlbiB0aGUgVk0gd2FzIHRyeWluZyB0byByZXN1bWUgYmFjayBmcm9tIHRoZSAnbmV3JyANCj4g
PiBrZXJuZWwgdG8gdGhlICdvbGQnIGtlcm5lbCwgdGhlc2UgZXZlbnRzIGhhcHBlbmVkOg0KPiA+
DQo+ID4gMS4gdGhlIG5ldyBrZXJuZWwgbG9hZGVkIHRoZSBzYXZlZCBzdGF0ZSBmcm9tIGRpc2sg
dG8gbWVtb3J5Lg0KPiA+DQo+ID4gMi4gdGhlIG5ldyBrZXJuZWwgcXVpZXNjZWQgdGhlIGRldmlj
ZXMsIGluY2x1ZGluZyB0aGUgU0NTSSBEVkQgZGV2aWNlDQo+ID4gY29udHJvbGxlZCBieSB0aGUg
aHZfc3RvcnZzYyBsb3cgbGV2ZWwgU0NTSSBkcml2ZXIsIGkuZS4NCj4gPiBkcml2ZXJzL3Njc2kv
c3RvcnZzY19kcnYuYzogc3RvcnZzY19zdXNwZW5kKCkgd2FzIGNhbGxlZCBhbmQgdGhlIHJlbGF0
ZWQNCj4gPiB2bWJ1cyByaW5nYnVmZmVyIHdhcyBmcmVlZC4NCj4gPg0KPiA+IDMuIEhvd2V2ZXIs
IGRpc2tfZXZlbnRzX3dvcmtmbigpIC0+IC4uLiAtPiBjZHJvbV9jaGVja19ldmVudHMoKSAtPiAu
Li4NCj4gPiAgICAtPiBzY3NpX3F1ZXVlX3JxKCkgLT4gLi4uIC0+IHN0b3J2c2NfcXVldWVjb21t
YW5kKCkgd2FzIHN0aWxsIHRyeWluZyB0bw0KPiA+IHN1Ym1pdCBJL08gY29tbWFuZHMgdG8gdGhl
IGZyZWVkIHZtYnVzIHJpbmdidWZmZXIsIGFuZCBhcyBhIHJlc3VsdCwgYSBOVUxMDQo+ID4gcG9p
bnRlciBkZXJlZmVyZW5jZSBwYW5pYyBoYXBwZW5lZC4NCj4gDQo+IExhc3QgdGltZSBJIHJlcGxp
ZWQgdG8geW91IGluIGFib3ZlIGxpbms6DQo+IA0KPiAic2NzaV9kZXZpY2VfcXVpZXNjZSgpIGhh
cyBiZWVuIGNhbGxlZCBieSBzY3NpX2Rldl90eXBlX3N1c3BlbmQoKSB0byBwcmV2ZW50DQo+IGFu
eSBub24tcG0gcmVxdWVzdCBmcm9tIGVudGVyaW5nIHF1ZXVlLiINCj4gDQo+IFRoYXQgbWVhbnQg
bm8gYW55IG5vcm1hbCBGUyByZXF1ZXN0IGNhbiBlbnRlciBzY3NpIHF1ZXVlIGFmdGVyIHN1c3Bl
bmQsDQo+IGhvd2V2ZXIgcmVxdWVzdCB3aXRoIEJMS19NUV9SRVFfUFJFRU1QVCBpcyBzdGlsbCBh
bGxvd2VkIHRvIGJlIHF1ZXVlZA0KPiB0byBMTEQgYWZ0ZXIgc3VzcGVuZC4NCj4gDQo+IFNvIHlv
dSBjYW4ndCBmcmVlIHJlbGF0ZWQgdm1idXMgcmluZ2J1ZmZlciBjYXVzZSAgQkxLX01RX1JFUV9Q
UkVFTVBUDQo+IHJlcXVlc3QgaXMgc3RpbGwgdG8gYmUgaGFuZGxlZC4NCj4gDQo+IFRoYW5rcywN
Cj4gTWluZyBMZWkNCg0KQWN0dWFsbHkgSSB0aGluayBJIGZvdW5kIHRoZSBBUElzIHdpdGggdGhl
IGhlbHAgb2YgTG9uZyBMaToNCnNjc2lfaG9zdF9ibG9jayBhbmQgc2NzaV9ob3N0X3VuYmxvY2so
KS4gVGhlIG5ldyBBUElzIHdlcmUganVzdCBhZGRlZA0Kb24gMi8yOC4gOi0pDQoNClVubHVja2ls
eSBzY3NpX2hvc3RfYmxvY2soKSBkb2Vzbid0IGFsbG93IGEgc3RhdGUgdHJhbnNpdGlvbiBmcm9t
IA0KU0RFVl9RVUlFU0NFIHRvIFNERVZfQkxPQ0sgYW5kIHJldHVybnMgLUVJTlZBTCBmb3IgdGhh
dCwgc28gSSBtYWRlIHRoZQ0KYmVsb3cgcGF0Y2ggYW5kIGl0IGxvb2tzIGhpYmVybmF0aW9uIGNh
biB3b3JrIHJlbGlhYmx5IGZvciBtZSBub3cuDQoNClBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGUg
Y2hhbmdlIHRvIHNjc2lfZGV2aWNlX3NldF9zdGF0ZSgpIGlzIE9LLg0KDQpJZiB0aGUgcGF0Y2gg
bG9va3MgZ29vZCwgSSBwbGFuIHRvIHNwbGl0IGFuZCBwb3N0IGl0IHNvbWV0aW1lIG5leHQgd2Vl
ay4NCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zY3NpX2xpYi5jIGIvZHJpdmVycy9zY3Np
L3Njc2lfbGliLmMNCmluZGV4IDQ3ODM1YzRiNGVlMC4uMDZjMjYwZjZjZGFlIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy9zY3NpL3Njc2lfbGliLmMNCisrKyBiL2RyaXZlcnMvc2NzaS9zY3NpX2xpYi5j
DQpAQCAtMjI4NCw2ICsyMjg0LDcgQEAgc2NzaV9kZXZpY2Vfc2V0X3N0YXRlKHN0cnVjdCBzY3Np
X2RldmljZSAqc2RldiwgZW51bSBzY3NpX2RldmljZV9zdGF0ZSBzdGF0ZSkNCiAgICAgICAgICAg
ICAgICBzd2l0Y2ggKG9sZHN0YXRlKSB7DQogICAgICAgICAgICAgICAgY2FzZSBTREVWX1JVTk5J
Tkc6DQogICAgICAgICAgICAgICAgY2FzZSBTREVWX0NSRUFURURfQkxPQ0s6DQorICAgICAgICAg
ICAgICAgY2FzZSBTREVWX1FVSUVTQ0U6DQogICAgICAgICAgICAgICAgY2FzZSBTREVWX09GRkxJ
TkU6DQogICAgICAgICAgICAgICAgICAgICAgICBicmVhazsNCiAgICAgICAgICAgICAgICBkZWZh
dWx0Og0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9zdG9ydnNjX2Rydi5jIGIvZHJpdmVycy9z
Y3NpL3N0b3J2c2NfZHJ2LmMNCmluZGV4IGZiNDE2MzY1MTllZS4uZmQ1MWQyZjAzNzc4IDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9zY3NpL3N0b3J2c2NfZHJ2LmMNCisrKyBiL2RyaXZlcnMvc2NzaS9z
dG9ydnNjX2Rydi5jDQpAQCAtMTk0OCw2ICsxOTQ4LDExIEBAIHN0YXRpYyBpbnQgc3RvcnZzY19z
dXNwZW5kKHN0cnVjdCBodl9kZXZpY2UgKmh2X2RldikNCiAgICAgICAgc3RydWN0IHN0b3J2c2Nf
ZGV2aWNlICpzdG9yX2RldmljZSA9IGh2X2dldF9kcnZkYXRhKGh2X2Rldik7DQogICAgICAgIHN0
cnVjdCBTY3NpX0hvc3QgKmhvc3QgPSBzdG9yX2RldmljZS0+aG9zdDsNCiAgICAgICAgc3RydWN0
IGh2X2hvc3RfZGV2aWNlICpob3N0X2RldiA9IHNob3N0X3ByaXYoaG9zdCk7DQorICAgICAgIGlu
dCByZXQ7DQorDQorICAgICAgIHJldCA9IHNjc2lfaG9zdF9ibG9jayhob3N0KTsNCisgICAgICAg
aWYgKHJldCkNCisgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KDQogICAgICAgIHN0b3J2c2Nf
d2FpdF90b19kcmFpbihzdG9yX2RldmljZSk7DQoNCkBAIC0xOTY4LDEwICsxOTczLDE1IEBAIHN0
YXRpYyBpbnQgc3RvcnZzY19zdXNwZW5kKHN0cnVjdCBodl9kZXZpY2UgKmh2X2RldikNCg0KIHN0
YXRpYyBpbnQgc3RvcnZzY19yZXN1bWUoc3RydWN0IGh2X2RldmljZSAqaHZfZGV2KQ0KIHsNCisg
ICAgICAgc3RydWN0IHN0b3J2c2NfZGV2aWNlICpzdG9yX2RldmljZSA9IGh2X2dldF9kcnZkYXRh
KGh2X2Rldik7DQorICAgICAgIHN0cnVjdCBTY3NpX0hvc3QgKmhvc3QgPSBzdG9yX2RldmljZS0+
aG9zdDsNCiAgICAgICAgaW50IHJldDsNCg0KICAgICAgICByZXQgPSBzdG9ydnNjX2Nvbm5lY3Rf
dG9fdnNwKGh2X2Rldiwgc3RvcnZzY19yaW5nYnVmZmVyX3NpemUsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgaHZfZGV2X2lzX2ZjKGh2X2RldikpOw0KKyAgICAgICBpZiAo
IXJldCkNCisgICAgICAgICAgICAgICByZXQgPSBzY3NpX2hvc3RfdW5ibG9jayhob3N0LCBTREVW
X1JVTk5JTkcpOw0KKw0KICAgICAgICByZXR1cm4gcmV0Ow0KIH0NCg0KVGhhbmtzLA0KLS0gRGV4
dWFuDQo=
