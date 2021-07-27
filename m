Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1433D7C13
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 Jul 2021 19:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbhG0RXN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 27 Jul 2021 13:23:13 -0400
Received: from mail-dm6nam11on2098.outbound.protection.outlook.com ([40.107.223.98]:36736
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229494AbhG0RXM (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 27 Jul 2021 13:23:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIjvWyXFA0WqfMR+Oglflp0w4c4jzBIa6qAKi9s5nNYQzssBaKrp15EXT/Q5wT21lWIJedUB1TUI2iwnM3Ac90IH9OM4uphpBHqKsmJqBXRo/FaPOnVUkfiJVw/UpHbmhXw0Sqkb7tuLHvy69AJEQOYADC9Hw67Q65I9m16H/lb9fhWD2naF/yU5Fi6o/u39iKq7gW7e3hCbI+vjfiHjBdc7W6jV0HuRqiHXoNUZPa5keHSAtr1e2CIZADp84QBIMeDLSEczIS/8ySZ0k94GlCxjPfO+bn7UpDlY7UwtCZjr5AVplF0ihCKnm4SAqCS6biPM4exNHRkK8bLhHIprbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAMFsWgtS7MsKBOmSbxHqoU2seIeWqNaiQ46niK73eU=;
 b=Bo7EVJTshAyIW5WABtMj2gizZku3X7Jt0BQK32rFDJGjSn3un4PeQYSpV0v/8KNHGUDNpjmTiyoz7JQeGl1EIXNY31poZ2z7lM5/5JyUKVuuPey6ckXP7XQiZGKKZS+FFQ/EGQ4jBTA7wkdRAV4h8p9Qhzam9uepDOO4lAaePsffgnJjOmBiOCK7Du3jKhocfy8rpLptM4lwn/KGaE4Nyq3wVo34rHilGm7H3FLMmuexPz/hb9P9OBUAYBn84bsJIG8HC0KVGhW0NQxk0U1bEXnQM5dq00X2VY/5bKQAqRqU1EmRoIozhTnnoSPqi+LAmZyXW+tLIjgINAlyXISEcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAMFsWgtS7MsKBOmSbxHqoU2seIeWqNaiQ46niK73eU=;
 b=Jhc/LqTT7vPCszKUlNg2CtDUlazwRzli1dtqZAgyeYnDZAVytVtg5Z2yAxLznbb613cd0zF0H9S1QTHAk2gJayEswG6Lt1wNREuNDGNVbRh5WWKvFtwEPYvd7bvBx8msdyI81YKy2lO7lN7iMTTLSsfTAjVVx3/0xXctaxyA2E0=
Received: from MW4PR21MB2002.namprd21.prod.outlook.com (2603:10b6:303:68::18)
 by MWHPR21MB0830.namprd21.prod.outlook.com (2603:10b6:300:76::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.4; Tue, 27 Jul
 2021 17:23:10 +0000
Received: from MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51]) by MW4PR21MB2002.namprd21.prod.outlook.com
 ([fe80::292a:eeea:ee64:3f51%4]) with mapi id 15.20.4394.005; Tue, 27 Jul 2021
 17:23:10 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "viremana@linux.microsoft.com" <viremana@linux.microsoft.com>,
        "nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>
Subject: RE: [PATCH v3] hyperv: root partition faults writing to VP ASSIST MSR
 PAGE
Thread-Topic: [PATCH v3] hyperv: root partition faults writing to VP ASSIST
 MSR PAGE
Thread-Index: AQHXgtPz/n7CxiZ6zUi9GbDbsi36lqtW+2kQgAAUBoCAAAGPUA==
Date:   Tue, 27 Jul 2021 17:23:10 +0000
Message-ID: <MW4PR21MB20025A2D5D768E6E8405397FC0E99@MW4PR21MB2002.namprd21.prod.outlook.com>
References: <20210727104044.28078-1-kumarpraveen@linux.microsoft.com>
 <MW4PR21MB20021A51BE9960E10C08FE6FC0E99@MW4PR21MB2002.namprd21.prod.outlook.com>
 <1a14d92d-c666-72ba-6c2d-e4385e36a056@linux.microsoft.com>
In-Reply-To: <1a14d92d-c666-72ba-6c2d-e4385e36a056@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f011ef-0aef-41f1-72bb-08d9512334c7
x-ms-traffictypediagnostic: MWHPR21MB0830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR21MB0830FED7AE81F7A1660209F8C0E99@MWHPR21MB0830.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: goliX2k3bU8Wk7SWwuj7Kn/resJW5oV3N1YbkxmTP4CahXet0+AkQJBxK3rQe8e1NkiJWW+PdS4zjaQ4asS0ESj76m0Z6QpFSUJQwFFi9FexUnMHHHXZ+V56SK5d234htrQQATIynz9EyzAXIiH3f+KS8aiJrTw3Vmy9c+s5UKbgc0UEuKX/hdSBYINk4ga7xnZkijHHIoO+H5WrPLicxkaqV3kJjgt9+49V8UXZ/CFntzaRDFA5pfFY4UJiAppDmtYl8t7caJewZ3pS3BpabjFqy2QUDHwrM9FtJGff09RaD7DclhZRrcSGxGqKB6w9/Ku3omOx8xGJBfkfBovTlXufDAEa5M9BezIIcdJUNKtmm/pCrWf/FzX1VZSl7KXMH1c+qd75kuAjr9Oyk5iEFXPRRjMELbMK7IOJuuHj8O0UZjp3+pOJI4Shmj8g63bwH+rUgMZe4LASLyi8trzvoaJzAb2guLoZ0Ww/g/Y3p0OxbcBnVmlE5K5PlT+GjuHzbONS772e/tqLmNjzsKhoYBSPQGc7TINi3icBOSXQJY8Iox62QcB2TABV/rxJ4E/PUaQkEYlHM909QqWrYbtnKx/F+8/L0FwRsTbLGSv+MxeewmCnwdINkxl0IbvlL7TezDjb3/LHPbyTrNWhcnwx0eETg4qNeNUYUE+BheCg4sA9SWUdW86ls3pMxQrMU8yOjPoWSRbY+KrB5NupEOF8sA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR21MB2002.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(54906003)(64756008)(110136005)(66476007)(508600001)(66446008)(8676002)(38100700002)(8990500004)(316002)(52536014)(66946007)(107886003)(83380400001)(5660300002)(2906002)(33656002)(122000001)(10290500003)(186003)(86362001)(71200400001)(6506007)(76116006)(82950400001)(9686003)(55016002)(82960400001)(7696005)(8936002)(4326008)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW13WjJKRjREQ3JwT0JVSU9QN3pya09EeGkrREtjbUVkUG0yU0dnZWpYYU8x?=
 =?utf-8?B?czdnL3BMY2hzRjhxMnpNZTQ4MTQwcjZtZ25YTUwvckkraDNLSUgzVkxtNVYv?=
 =?utf-8?B?cGxtSDBwOU5WUVRtREhpRTBNNFhVRXN5c3dwL2lWSjAyb1oxY3I5eUVyREF6?=
 =?utf-8?B?TFNQbTZkemZoK2QyTWVBRzF6UmdYZmJ4aWlmcThmOWJ3eVhOUzZXb2FvK1Vj?=
 =?utf-8?B?aCtrMndTdmRwZ3IzM1RsaXJUdWNUKzlCQ2dRaTZmcjFMNFRDY25uSjZ0T0N0?=
 =?utf-8?B?Y2lqMmUxVjVBcFBYdFFKQjVEL2ZBVGh5cFJNNURuSEI5eFgvbHNLS2tVTVJ3?=
 =?utf-8?B?YndxQ3Z4UWp5Z1VzZzFNcXNFZ202cE9mVjBFR2IwZ0M5bDNHMzJ4WDBlS2VG?=
 =?utf-8?B?WGVjcDYwanoyNms1ak1pOHFxTGIrK2hnZ2VicHBPWjFES3dQOC91QlVrL29P?=
 =?utf-8?B?MGordURkMld0b0sxbjhqWER1WHVZcXo5ZnhpOFhMSEMwWC84MjRJWXVWdHFt?=
 =?utf-8?B?dDRRQWFiQXhjNHQ3K2IwMFcvTURNMHhLNFJRUjgzRk9Ic3pzeFZvbmpOTDJi?=
 =?utf-8?B?WldNZFAwdXROem9GUTcwbXQxdkZyZVJWMTZ5Snl1aUY3MmNwUUVSZ0JoK3R3?=
 =?utf-8?B?NlRZTGF2K29rcXVFOVpNYzlvYy9Ca1lpN2Z3TzBhWHNmSFZxeWNHZVFVQVY3?=
 =?utf-8?B?WVpVNHBSVUVDMTB4MU9LUnpEdzFiMUMrendPWCtLb21Rdno0YTJxaG1xT0xD?=
 =?utf-8?B?NkkvRmpVTGIwY2krRmhwT0drMGdqTjA1WFhsZjRtdmJtQnJyVmZmNVFXSFF5?=
 =?utf-8?B?TE9uMzhXNEJwbVNoTnNrbFI5WjhkQW1WUitIdkpMQVlIZ09tL29OR1cvUS9D?=
 =?utf-8?B?Q2lzNWFsNEJaUzBDOEZRVDR6QVhsaHVzRkZUS2djWTZVVlBrQjRTVUxWMDNq?=
 =?utf-8?B?bUNWNHljUVQxUWIxdXg1Q0w2NGs1bmkyNWt6S3djbDBRNmNwRWVuODdYR0NK?=
 =?utf-8?B?S0tia1N3UVk0YlF5TkN5WFZzbU13UnN0YllWNldwRUlMYzZyOVJFWGdaZEN3?=
 =?utf-8?B?RkJIakxOTXU0OWRzZmZUVzJycmN6ODFreURtMGdMeFdDUVNiRFVPSUhIWVJQ?=
 =?utf-8?B?TDFxbUNLNXd2aGhxc0hQdUFTaTNrUUVzbTVVZjdOSlloSCtWSjhhZHJCZTFi?=
 =?utf-8?B?ZnJkSnUwOVVqWDZ3d093QkhCZUVoY05PQndFSGlFeGVKNm1zVElzaG9TUGgz?=
 =?utf-8?B?aDgwSk9SbC9vMVRjOUpWSWFpTGJmRDJlV2xIQktpcFNQdTdQK0tjU1IrL2ZW?=
 =?utf-8?B?NXoxVkRtV2lTTkJtV1dtYjhnNjVzb3BnM1dheis3eG1Gdzd4QVNVODl4VHZ6?=
 =?utf-8?B?Z2NoT2pwemVJd2NaWWNHaTFzZnJQMFd2a1Q3WlJYQ0VNV1RnOEo3VUE1QWFj?=
 =?utf-8?B?VURyc3BNSkp4R0NHQ0pxYUxvSkljblhnOWpiQjVYcFZqTHFxOE9Rb3VaWHpt?=
 =?utf-8?B?RElPdEdVTzJEbDJFZXZZb2loaWx0cWhaTWRMZTN2RU80MVNvQ1BrRGNnQk1F?=
 =?utf-8?B?K1lhOFRDa1JCNWFWbUxEamwxcjBHK0MvaUtYL044anMyV05GQUNpZjFLSTVN?=
 =?utf-8?B?ZlJVd3pPWCt1ZTRMN011VUVTY05rOUxDQjRRMHVCYkVYRVBqalJ2SVZmZG5w?=
 =?utf-8?B?N0tzRDZhSXM2YUQ3UkQ5Z052Q2ltclZLVnRSTFgrNmhSZHFyU0xJSzRCLzcr?=
 =?utf-8?B?VklPbFhSV3VyYXYwUzBjUmdTeDB4WWlUNU1yMXpSU01nZWhRUkxSaTZuNEhU?=
 =?utf-8?B?UFlOWWhPK0F0MndFcVdFTVdkMVFobDdpZWNSWjVheWFUbVFsQ1Mvem8vdVoz?=
 =?utf-8?Q?ERaS8OUWQ7fxJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR21MB2002.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f011ef-0aef-41f1-72bb-08d9512334c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 17:23:10.0369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JmwWP45FDp93X1ujrew0OtA5xbN45iBLBxFsqIdtTiCKsl5jHZh8c1dbwNz9RdrI0/w8qv2Pu12qfKDVo/6oLgvbgNevQSvdMlJlXv2k77M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0830
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiA+PiAgc3RhdGljIGludCBodl9jcHVfaW5pdCh1bnNpZ25lZCBpbnQgY3B1KQ0KPiA+PiAgew0K
PiA+PiArCXVuaW9uIGh2X3ZwX2Fzc2lzdF9tc3JfY29udGVudHMgbXNyOw0KPiA+PiAgCXN0cnVj
dCBodl92cF9hc3Npc3RfcGFnZSAqKmh2cCA9ICZodl92cF9hc3Npc3RfcGFnZVtzbXBfcHJvY2Vz
c29yX2lkKCldOw0KPiA+PiAgCWludCByZXQ7DQo+ID4+DQo+ID4+IEBAIC01NCwyNyArNTUsNDEg
QEAgc3RhdGljIGludCBodl9jcHVfaW5pdCh1bnNpZ25lZCBpbnQgY3B1KQ0KPiA+PiAgCWlmICgh
aHZfdnBfYXNzaXN0X3BhZ2UpDQo+ID4+ICAJCXJldHVybiAwOw0KPiA+DQo+ID4gTm90IHJlbGF0
ZWQgdG8gdGhpcyBjb2RlLCBidXQgSSBhbSBub3Qgc3VyZSBhYm91dCB0aGUgdXNlZnVsbmVzcyBv
ZiB0aGlzIE5VTEwgY2hlY2sgYXMNCj4gPiB3ZSBoYXZlIGFscmVhZHkgYWNjZXNzZWQgdGhpcyBw
b2ludGVyIGFib3ZlLiBJZiBpdCB3YXMgTlVMTCwgdGhpbmdzIHdvdWxkIGFscmVhZHkNCj4gPiBi
bG93IHVwLg0KPiA+DQo+IFdoYXQgSSB1bmRlcnN0b29kLCBodnAgd2lsbCBwb2ludCB0byAiaHZf
dnBfYXNzaXN0X3BhZ2Ugc3RhY2sgYWRkcmVzcyArIHNtcF9wcm9jZXNzb3JfaWQoKSINCj4gU28s
IHdlIGFyZSBnb29kLCBhbmQgdGhpcyBOVUxMIGNoZWNrIGlzIHJlcXVpcmVkLCBhcyBpbiB3aGVu
IHdlIGRlLXJlZmVyZW5jZSB0aGUgbG9jYXRpb24sIGxhdGVyIGluIHRoZSBjb2RlLCBpdCBtYXkg
ZmF1bHQuDQo+IFBsZWFzZSBkbyBjb3JyZWN0IG1lIGlmIG15IHVuZGVyc3RhbmRpbmcgaXMgd3Jv
bmcgaGVyZS4gVGhhbmtzLg0KPiANCg0KJ2h2X3ZwX2Fzc2lzdF9wYWdlJyBjb21lcyBmcm9tIHRo
ZSBoZWFwLCB0aGVyZSBpcyBub3RoaW5nIG9uIHRoZSBzdGFjayB0aGVyZS4gQXMgSQ0KbWVudGlv
bmVkIHByZXZpb3VzbHksIGlmICdodl92cF9hc3Npc3RfcGFnZScgd2FzIE5VTEwsIHdlIHdvdWxk
IGhhdmUgYWxyZWFkeQ0KY3Jhc2hlZCBieSBub3csIGFzIHdlIGFyZSBhY2Nlc3NpbmcgaXQgYWJv
dmUuIFNvLCB0aGUgY2hlY2sgaGVyZSBpcyB1c2VsZXNzIGluIG15IG9waW5pb24uDQpCdXQsIHNp
bmNlIHRoaXMgaXMgY29kZSB0aGF0IHRoaXMgcGF0Y2ggZG9lc24ndCB0b3VjaCwgaXRzIGZpbmUg
dG8gbGVhdmUgaXQgYXMgaXMgZm9yIHRoaXMgcGF0Y2guDQpJIHdhcyBqdXN0IHBvaW50aW5nIGl0
IG91dC4NCg0KLSBTdW5pbA0KDQo=
