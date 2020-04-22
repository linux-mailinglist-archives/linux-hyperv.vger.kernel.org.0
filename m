Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AA61B3785
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2020 08:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgDVGYz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Apr 2020 02:24:55 -0400
Received: from mail-eopbgr1320138.outbound.protection.outlook.com ([40.107.132.138]:30976
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgDVGYz (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Apr 2020 02:24:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Os2Cm14jNAZwlMIRY/WMSgm50EBtIVvxe6lFp9JzFybUYO0lBw8DkDtDXAmchbj09r0tijtriRTpeC/JHMFdcBBDa2EeeDvO059OIwYgIgqN017fO8s58d/q2fm+Kat4gxHAvn1EKDXQVJWsYDve0HpSN1TdCvKVIochRaxyHLn8xEmaKvPXJBKSiDRKAXF/LfyHtSZnJXZNg9XryaCR2DR0GecC/pqMWALF2V4neBey4J6Pzrr0vknyxZknUGLEZlIxR99gChhO+/e4CrTwCDs5J3rgv3gMsc9Apji9lXsZFSZNdwFRg/HejIH2iVOWg3qcPqMJx60DPjMCjAN15A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnUupzNRTsDxrT2bqR/fpkK44UyZiOqGoT2Hx1yB0r4=;
 b=Cl79goi9N7h4vl4BavL10NPNUym3jhMMTd55MYSpZyFG2xv85iMOSAZgP4Oh4sBLhaR1gVSEH/B4R8gTWlk2T2waAPKOmFhwCS97om5SWJrLGQ5l6C8BZtsfs9xrEzRhqU5Ot2lCeDwVJLP/DjRdjz99OAJU/OOOMmAVy3YQIt8mjjE5XZsKfWwNIgtI3lK06BRqcG7jssO5fcJgCypiK8NWQdYVSggWrtSHjmnPBrC1NRDzxFC+BWUU1dm4pCAK2GQZrhUodPCa6dVM6dMUP1e7uROUKkf9ghxU82RDJ8E17GTvB8yVOefLlkJSsiHmKeHPFLhjfR5QZs7sgAhWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnUupzNRTsDxrT2bqR/fpkK44UyZiOqGoT2Hx1yB0r4=;
 b=WizpsYYrVw6QK7kJhCfHd3HNtM7cA53o/sVdEUwVAYMOTLNAD6XEvSgNcTwoDFy04HsuYNGGXWHzDXUq7cRlykKfh82sL66pVCDBYZN5d8BMzUZJOsdvt2YTL0Z+1BCd3jEnDkdDLl9nD2ix3J9YPBukULfRuLVXrkWmj+yXdBg=
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b2::12)
 by HK0P153MB0337.APCP153.PROD.OUTLOOK.COM (2603:1096:203:b6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.2; Wed, 22 Apr
 2020 06:24:43 +0000
Received: from HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a]) by HK0P153MB0273.APCP153.PROD.OUTLOOK.COM
 ([fe80::2d07:e045:9d5b:898a%2]) with mapi id 15.20.2958.006; Wed, 22 Apr 2020
 06:24:43 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Balsundar P <Balsundar.P@microchip.com>,
        Christoph Hellwig <hch@lst.de>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Topic: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
Thread-Index: AQHWGGMw6DFeJK2tFE2eFTHRpRyDH6iElrSg
Date:   Wed, 22 Apr 2020 06:24:43 +0000
Message-ID: <HK0P153MB027395755C14233F09A8F352BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
In-Reply-To: <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-22T06:24:41.0740757Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1da1867c-6dad-48c0-b806-a2196b5a7ff0;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
x-originating-ip: [2601:600:a280:7f70:a0d3:b235:bb01:7ca2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d63f8fc4-b54b-49cf-0980-08d7e685d8d2
x-ms-traffictypediagnostic: HK0P153MB0337:|HK0P153MB0337:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HK0P153MB03373973A41F94418EE582F5BFD20@HK0P153MB0337.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0P153MB0273.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(316002)(2906002)(7416002)(54906003)(86362001)(110136005)(4326008)(478600001)(10290500003)(82950400001)(82960400001)(8936002)(81156014)(8676002)(71200400001)(6506007)(5660300002)(53546011)(7696005)(8990500004)(55016002)(186003)(9686003)(66946007)(66446008)(76116006)(33656002)(64756008)(66556008)(52536014)(107886003)(66476007)(921003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JaH3HegtktYxQso8gbrrUEi6Szbq7nZGGsJKo8kc+jiqsGRP6/6HpRhuBDcP02tE1SvXddd9Ea8i02HN+syvAO8YEsKPuc84fWVsWsCn7z/vwDq8nfR423K+dp57p30/5c84HCEDmzwATCAD9jhpu4hdrol6DA8kHZMZiIBmNK56ZIjSIAKllV0/vdxs0BaNrfYD7DOSgQNXUq6lYe+sSFsX1QvoHlF1NrMF4aHiPT5o2bUwqySqfIQ1Aa23gqay8ckgxIfvFBEZtBVS2G4Y6T+pb30dA4/hzO0K1MOUw8zoQfFNuhc270QMdz/NcvQH2eS8ENHiVjDg/0yMA6lMM3VOiXoX2kHv+eewd3pGR3gmYYrSGV3IJcjIYaUQrq/4eihZAZ/ucXkSL3lmtvDcRkQU2TN9o+nyZq7dLcLzbUK8PsIVg85SeqCyyWuMoTUIVSghMbINWLGpWgyhqwvJIBQch3X5APlQjUtNB27/yWs=
x-ms-exchange-antispam-messagedata: W9uLZ7g5AYirXzRi5jhW8jq9FX6oafViqj2al6PJOXW0eDsb8beUyJa9gJOupNM9x8Invicd1NECLdlJutS/IkrbT7rWuys1m9hsN/1bloBN+hnwrzggAq1WdgmPbpzAy0y0cXkLqR9HhB48IP3nmpVnon0wB5yTGrcaZWNX3nsLaHh9LrrKoZ7jvR6RTXbTW1hg5Pv2enCBzfsE/WmVJBIK0slpkKgJ7iRMNFXykhncbp/EX5mMqm9SqXjDqlam4Sxg6z1s795m66zsNmItrzPg5/YAMa7nbt8yq4bNbkc363nuzPdFsXV5MEXIEAKrNIzrut9ZTcEHOyTr00BHArAOJ9Uf2bfczuWudR5ySDL1zuMEnvirZjvEL4jaTBBY6AgatNC+aWNsQhbUyjFxoatB8mjhQQVjV06AQauWOOG4dw6u/JwhQat3vSwY5l7rAdZdvXjq+5CnhJr9Haun64tyZTloR7FifjBzxZqDmwUJfNiamnTSlIjJxLVMyJRXmsdNR/30ZD6m8QRBqh/HZTlnyFgJZsD9kkCLKDdTrKcraMZrOgIGOm9/vech//6y7dM4A/B/bGoDtFe1AOQwCb3+NONk+oh/gKvUdzoOYgqFpm+OhZTajq+uLwPNK3qQ3ZnPiQSoFoI5sZWBsQZNZngvJd3u/pJRd3IzzgXmmhGwjlmjTH6+S5BmrnnpdC+ByeMqmbScgTFeWc/jUILg8af7yvbSuZWSxPszp36Xr+4o+uqglCS/j3eS+LPMptAJMoHIgx7JXfEWqYRAK4tum2U8L5PWPCbkYsby2gkzQejpMSuWPIZdyx917wryhodqnOTtEura8MS9NzyfoeVTCVn+mREBG/6C/8VAT9Y+7eM=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d63f8fc4-b54b-49cf-0980-08d7e685d8d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 06:24:43.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UB8CzpESfsLi1Jpu6GEW8B1gYHD9+vhgimTa426TBw3JsWTqPDCjZWQwcR1q2RBb0V0wrbFlUgjL7Kj4gug85A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0P153MB0337
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4NCj4gU2VudDogVHVl
c2RheSwgQXByaWwgMjEsIDIwMjAgMTA6MDIgUE0NCj4gT24gNC8yMS8yMCA1OjE3IFBNLCBEZXh1
YW4gQ3VpIHdyb3RlOg0KPiA+IER1cmluZyBoaWJlcm5hdGlvbiwgdGhlIHNkZXZzIGFyZSBzdXNw
ZW5kZWQgYXV0b21hdGljYWxseSBpbg0KPiA+IGRyaXZlcnMvc2NzaS9zY3NpX3BtLmMgYmVmb3Jl
IHN0b3J2c2Nfc3VzcGVuZCgpLCBzbyBhZnRlcg0KPiA+IHN0b3J2c2Nfc3VzcGVuZCgpLCB0aGVy
ZSBpcyBubyBkaXNrIEkvTyBmcm9tIHRoZSBmaWxlIHN5c3RlbXMsIGJ1dCB0aGVyZQ0KPiA+IGNh
biBzdGlsbCBiZSBkaXNrIEkvTyBmcm9tIHRoZSBrZXJuZWwgc3BhY2UsIGUuZy4gZGlza19jaGVj
a19ldmVudHMoKSAtPg0KPiA+IHNyX2Jsb2NrX2NoZWNrX2V2ZW50cygpIC0+IGNkcm9tX2NoZWNr
X2V2ZW50cygpIGNhbiBzdGlsbCBzdWJtaXQgSS9PDQo+ID4gdG8gdGhlIHN0b3J2c2MgZHJpdmVy
LCB3aGljaCBjYXVzZXMgYSBwYW5pYyBvZiBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UsDQo+ID4g
c2luY2Ugc3RvcnZzYyBoYXMgY2xvc2VkIHRoZSB2bWJ1cyBjaGFubmVsIGluIHN0b3J2c2Nfc3Vz
cGVuZCgpOiByZWZlcg0KPiA+IHRvIHRoZSBiZWxvdyBsaW5rcyBmb3IgbW9yZSBpbmZvOg0KPiA+
IC4uLg0KPiA+IEZpeCB0aGUgcGFuaWMgYnkgYmxvY2tpbmcvdW5ibG9ja2luZyBhbGwgdGhlIEkv
TyBxdWV1ZXMgcHJvcGVybHkuDQo+ID4NCj4gPiBOb3RlOiB0aGlzIHBhdGNoIGRlcGVuZHMgb24g
YW5vdGhlciBwYXRjaCAic2NzaTogY29yZTogQWxsb3cgdGhlIHN0YXRlDQo+ID4gY2hhbmdlIGZy
b20gU0RFVl9RVUlFU0NFIHRvIFNERVZfQkxPQ0siIChyZWZlciB0byB0aGUgc2Vjb25kIGxpbmsN
Cj4gYWJvdmUpLg0KPiANCj4gSSBkb24ndCBsaWtlIHRoaXMgcGF0Y2guIEl0IG1ha2VzIHRoZSBi
ZWhhdmlvciBvZiB0aGUgc3RvcnN2YyBkcml2ZXINCj4gZGlmZmVyZW50IGZyb20gZXZlcnkgb3Ro
ZXIgU0NTSSBMTEQuIE90aGVyIFNDU0kgTExEcyBkb24ndCBuZWVkIHRoaXMNCj4gY2hhbmdlIGJl
Y2F1c2UgdGhlc2UgZG9uJ3QgZGVzdHJveSBJL08gcXVldWVzIHVwb24gc3VzcGVuZC4NCj4gDQo+
IEJhcnQuDQoNClVwb24gc3VzcGVuZCwgSSBzdXBwb3NlIHRoZSBvdGhlciBMTERzIGNhbiBub3Qg
YWNjZXB0IEkvTyBlaXRoZXIsIHRoZW4NCndoYXQgZG8gdGhleSBkbyB3aGVuIHNvbWUga2VybmVs
IHRocmVhZCBzdGlsbCB0cmllcyB0byBzdWJtaXQgSS9PPyBEbyANCnRoZXkgImJsb2NrIiB0aGUg
SS9PIHVudGlsIHJlc3VtZSwgb3IganVzdCByZXR1cm4gYW4gZXJyb3IgaW1tZWRpYXRlbHk/DQoN
CkkgaGFkIGEgbG9vayBhdCBkcml2ZXJzL3Njc2kveGVuLXNjc2lmcm9udC5jLiBJdCBsb29rcyB0
aGlzIExMRCBpbXBsZW1lbnRzDQphIG1lY2hhbmlzbSBvZiBtYXJraW5nIHRoZSBkZXZpY2UgYnVz
eSB1cG9uIHN1c3BlbmQsIHNvIGFueSBJL08gd2lsbA0KaW1tZWRpYXRlbHkgZ2V0IGFuIGVycm9y
IFNDU0lfTUxRVUVVRV9IT1NUX0JVU1kuIElNTyB0aGUNCmRpc2FkdmFudGFnZSBpczogdGhlIG1l
Y2hhbmlzbSBvZiBtYXJraW5nIHRoZSBkZXZpY2UgYnVzeSBsb29rcw0KY29tcGxleCwgYW5kIHRo
ZSBob3QgcGF0aCAucXVldWVjb21tYW5kKCkgaGFzIHRvIHRha2UgdGhlDQpzcGlubG9jayBzaG9z
dC0+aG9zdF9sb2NrLCB3aGljaCBzaG91bGQgYWZmZWN0IHRoZSBwZXJmb3JtYW5jZS4NCg0KSXQg
bG9va3MgZHJpdmVycy9zY3NpL25zcDMyLmM6IG5zcDMyX3N1c3BlbmQoKSBhbmQgDQpkcml2ZXJz
L3Njc2kvM3ctOXh4eC5jOiB0d2Ffc3VzcGVuZCgpIGRvIG5vdGhpbmcgdG8gaGFuZGxlIG5ldyBJ
L08gDQphZnRlciBzdXNwZW5kLiBJIGRvdWJ0IHRoaXMgaXMgY29ycmVjdC4NCg0KSXQgbG9va3Mg
ZHJpdmVycy9zY3NpL2hpc2lfc2FzL2hpc2lfc2FzX3YzX2h3LmM6IGhpc2lfc2FzX3YzX3N1c3Bl
bmQoKQ0KdHJpZXMgdG8gdXNlIHNjc2lfYmxvY2tfcmVxdWVzdHMoKSBhcyBhIG1lYW5zIG9mIGJs
b2NraW5nIG5ldyBJL08sIGJ1dA0KSSBkb3VidCBpdCBjYW4gd29yazogc2NzaV9ibG9ja19yZXF1
ZXN0cygpIG9ubHkgc2V0cyBhIHZhcmlhYmxlIC0tDQpob3cgY291bGQgdGhpcyBwcmV2ZW50IGFu
b3RoZXIgY29uY3VycmVudCBrZXJuZWwgdGhyZWFkIHRvIHN1Ym1pdCBuZXcNCkkvTyB3aXRob3V0
IGEgcmFjZSBjb25kaXRpb24gaXNzdWU/DQoNClNvIGl0IGxvb2tzIHRvIG1lIHRoZXJlIGlzIG5v
IHNpbXBsZSBtZWNoYW5pc20gdG8gaGFuZGxlIHRoZSBzY2VuYXJpbw0KaGVyZSwgYW5kIEkgZ3Vl
c3MgdGhhdCdzIHdoeSB0aGUgc2NzaV9ob3N0X2Jsb2NrL3VuYmxvY2sgQVBJcyBhcmUNCmludHJv
ZHVjZWQsIGFuZCBhY3R1YWxseSB0aGVyZSBpcyBhbHJlYWR5IGFuIHVzZXIgb2YgdGhlIEFQSXM6
DQozZDNjYTUzYjE2MzkgKCJzY3NpOiBhYWNyYWlkOiB1c2Ugc2NzaV9ob3N0XyhibG9jayx1bmJs
b2NrKSB0byBibG9jayBJL08iKS4NCg0KVGhlIGFhY3JhaWQgcGF0Y2ggc2F5czogIlRoaXMgaGFz
IHRoZSBhZHZhbnRhZ2UgdGhhdCB0aGUgYmxvY2sgbGF5ZXIgd2lsbCANCnN0b3Agc2VuZGluZyBJ
L08gdG8gdGhlIGFkYXB0ZXIgaW5zdGVhZCBvZiBoYXZpbmcgdGhlIFNDU0kgbWlkbGF5ZXINCnJl
cXVldWVpbmcgSS9PIGludGVybmFsbHkiLiBJdCBsb29rcyB0aGlzIG1heSBpbXBseSB0aGF0IHVz
aW5nIHRoZSBuZXcgDQpBUElzIGlzIGVuY291cmFnZWQ/DQoNClNvcnJ5IGZvciBteSBsYWNrIG9m
IGtub3dsZWRnZSBpbiBMaW51eCBTQ1NJIHN5c3RlbSwgYnV0IElNSE8gdGhlIG5ldw0KQVBJcyBh
cmUgc2ltcGxlIGFuZCBlZmZlY3RpdmUsIGFuZCB0aGV5IHJlYWxseSBsb29rIGxpa2UgYSBnb29k
IGZpdCBmb3IgdGhlDQpoaWJlcm5hdGlvbiBzY2VuYXJpby4gQlRXLCBzdG9ydnNjX3N1c3BlbmQo
KSBpcyBub3QgYSBob3QgcGF0aCBoZXJlLA0Kc28gSU1PIEkgZG9uJ3QgaGF2ZSBhbnkgcGVyZm9y
bWFuY2UgY29uY2Vybi4NCg0KUFMsIGhlcmUgc3RvcnZzYyBoYXMgdG8gZGVzdHJveSBhbmQgcmUt
Y29uc3RydWN0IHRoZSBJL08gcXVldWVzOiB0aGUNCkkvTyBxdWV1ZXMgYXJlIHNoYXJlZCBtZW1v
cnkgcmluZ2J1ZmVycyBiZXR3ZWVuIHRoZSBndWVzdCBhbmQgdGhlDQpob3N0OyBpbiB0aGUgcmVz
dW1lIHBhdGggb2YgdGhlIGhpYmVybmF0aW9uIHByb2NlZHVyZSwgdGhlIG1lbW9yeSANCnBhZ2Vz
IGFsbG9jYXRlZCBieSB0aGUgJ25ldycga2VybmVsIGlzIGRpZmZlcmVudCBmcm9tIHRoYXQgYWxs
b2NhdGVkIGJ5DQp0aGUgJ29sZCcga2VybmVsLCBzbyBiZWZvcmUganVtcGluZyB0byB0aGUgJ29s
ZCcga2VybmVsLCB0aGUgJ25ldycga2VybmVsDQptdXN0IGRlc3Ryb3kgdGhlIG1hcHBpbmcgb2Yg
dGhlIHBhZ2VzLCBhbmQgbGF0ZXIgYWZ0ZXIgd2UganVtcCB0byANCnRoZSAnb2xkJyBrZXJuZWws
IHdlJ2xsIHJlLWNyZWF0ZSB0aGUgbWFwcGluZyB1c2luZyB0aGUgcGFnZXMgYWxsb2NhdGVkIA0K
YnkgdGhlICdvbGQnIGtlcm5lbC4gSGVyZSAiY3JlYXRlIHRoZSBtYXBwaW5nIiBtZWFucyB0aGUg
Z3Vlc3QgdGVsbHMNCnRoZSBob3N0IGFib3V0IHRoZSBwaHlzaWNhbCBhZGRyZXNzZXMgb2YgdGhl
IHBhZ2VzLg0KDQpUaGFua3MsDQotLSBEZXh1YW4NCg==
