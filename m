Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5E23227B
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Jul 2020 18:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgG2QWV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Jul 2020 12:22:21 -0400
Received: from mail-eopbgr700098.outbound.protection.outlook.com ([40.107.70.98]:47456
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726341AbgG2QWU (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Jul 2020 12:22:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djjnSaAx8ZHd8g9424XrNVk8lZtH8azm5gZuuAdLro0qyxbrqf95a9y0v8R4VRh1nbnG4LkwKe1ulRgqSkdATq8VrZn0VYCx3nCr/6qZfK5W7bZOK8nzj1WTLobZ5nXIN/J8UKGd7cbtqEMqkhvftE5Ga1ftRVHH3sRLUIjaMjuFrIxqyVSKVpmvEdRaAugrqPT1isPszSQ/urKhOleII/PhruSomWh0Y5ihyKRdeHJI5WA79qQvpr6/QxT9YblrHyxnNEpcgpJgsYzX3wsuUOVc0hs/b8gzOmcPs+cELg5BQzCEWGbNPOdyGijZuqilUpFDKVL7Z0oyE7SZSMbFbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2H8Brmggi4mWMcCuT3mtXYn8AEdI2qesKEYmLtCWkQ=;
 b=WImCFoayPIqsYuc143eKlvIiiOfi2nxR78KCCsKwaIbKuXllkdsDK7HWLKTrVM+yd0LUZj2cVZmJuVkNkIyDbfnpeR4Wj0Bb1Lf0x1TrCxOokoKX+GxubKhDK1qYppAMpW62s12YvrKfsjMNGn48cGY5Z4GMyB8oGWq53yLmQ8dcnZcxF31XYAiwpMYHijiAN6O4aXMGdZIOahODsYn3qtnNeVCb+aC8Yqr8GPRbRmfZIY0rl7fjBZ0CFdia+wbyG02bTt+ieoMOKl54Cyd+oXbUuBMeWX8p5wCXjFge82M/3LUo267hLgXUjkRXjO5kNPfSnhBaQMyiu8y2+nBx2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p2H8Brmggi4mWMcCuT3mtXYn8AEdI2qesKEYmLtCWkQ=;
 b=Wi8/DT43hNU/96f/iKzFodDkGBrhMfsS2JJnRbSCMb+PP5PAI3kS2/QrxWgVnqXX2DNVZ6cZNmC1/Oa9iezWO+ir2IxW28tYeWaiPQAsCeXpT+Tz2ge2T7sYwtmAOqaDJbihD53Dw1vbNW2G5nuiwXEgIgGD5h1cK16JmEm8t+0=
Received: from BN6PR21MB0836.namprd21.prod.outlook.com (2603:10b6:404:9e::14)
 by BN6PR21MB0771.namprd21.prod.outlook.com (2603:10b6:404:9c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.9; Wed, 29 Jul
 2020 16:22:18 +0000
Received: from BN6PR21MB0836.namprd21.prod.outlook.com
 ([fe80::81c5:8d93:da4:ec76]) by BN6PR21MB0836.namprd21.prod.outlook.com
 ([fe80::81c5:8d93:da4:ec76%14]) with mapi id 15.20.3239.001; Wed, 29 Jul 2020
 16:22:18 +0000
From:   Stephen Hemminger <sthemmin@microsoft.com>
To:     Andres Beltran <lkmlabelt@gmail.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH] hv_utils: Add validation for untrusted Hyper-V values
Thread-Topic: [PATCH] hv_utils: Add validation for untrusted Hyper-V values
Thread-Index: AQHWZR/iQ6HgFROTW0GjWwUNqZZCe6kdeuRwgAFAW4CAAAMlUA==
Date:   Wed, 29 Jul 2020 16:22:18 +0000
Message-ID: <BN6PR21MB083600994098D204DF141AB3CC700@BN6PR21MB0836.namprd21.prod.outlook.com>
References: <20200728204417.23912-1-lkmlabelt@gmail.com>
 <BN6PR21MB08361CE726C8D3541E657054CC730@BN6PR21MB0836.namprd21.prod.outlook.com>
 <CAGpZZ6un6VT2ZVje0tVXbZkvH_HH+pn2Du6WPa5qeJDOz7rUmg@mail.gmail.com>
In-Reply-To: <CAGpZZ6un6VT2ZVje0tVXbZkvH_HH+pn2Du6WPa5qeJDOz7rUmg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-29T16:22:15Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=57ced0d5-6a61-439b-ac8a-89e37fda176b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [204.195.22.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ac76835d-6e78-4b2f-3dbb-08d833db9039
x-ms-traffictypediagnostic: BN6PR21MB0771:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR21MB07712C3A9946C967DF552D7DCC700@BN6PR21MB0771.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ljOF9zkcfJi+LYQC33BcG3k3qg+Ee8oM6wqbr/MD1BpEVubvDhzKGxWSsrT0fo0hkU3b9Ct5Em0OoHLxc3nx5FuNkbqBAmTpzWvfq2kQFhL2+WoAty1uRin2IGTqce+JB1GPJ+PMXpz+fX8OKBVE6mxVd029LLFLQKOio6GsQlrjuPCqniTkSkNbZkgd1RZ5svegvbXowMQ5FnI+R8Zed8a55O4RIIpAy85dVlyTdiTFHbjci3bR0KC5mB6APQlSzhMrFWIKfXi1ZpowbSanPYrLDb3IETAljJm184wgrk+ETWaJP/tNTXf95I/FOzsmGKDlUn73uitnW0GBIAVHlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR21MB0836.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(5660300002)(7696005)(8936002)(316002)(86362001)(66556008)(6916009)(64756008)(66446008)(4744005)(10290500003)(107886003)(52536014)(66476007)(478600001)(82960400001)(82950400001)(2906002)(71200400001)(8676002)(4326008)(26005)(54906003)(8990500004)(9686003)(76116006)(53546011)(6506007)(66946007)(55016002)(186003)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Dm8xUg7SJzJIU8vBurnGddAP6n2ZTwKP0rGdxairJO4lonEZ+PYhkMffN+LiiM057lO79Fj14pDfQ6tFnYsOtON+zR+/Tjm8prcF+wdxk7rfjbZte5Of6cAmXZdfxVUoq6NIt6BuZ0AaslN+sSJb3YDVzgSmO4Hly4dJ76y1f07pIYzAq8cbIVRddkjEh/LsWTX7K667lTXN6N+q/4YgSKl9dCnCq4+dFRAy0PKivJqW67bx8z9ICdmyPz/BbxgmiyEPwcWqfkqioS+AxW5iAWs/BAD42RYZfJ+xzQUwyy06uR8QEM7c5MihHIZ70WL07WtWFmFl8mWmdRkg+XX8GpEWdpOmtzkDEdNeS1jdVHBW+yR/hn5ne7DTU1xbgakZ8lkubg9B+MiVY+C+KSLyBNdVIuyhmi6FlozWS1QGChJcM3HmcpjYOJQ32RWG6ucR04yE3JO9CQqloXG4kPEmI5iV6n1qtM1SOU89tEhDnJfQBFpY595mEoFbOEQm4ZvfJiwDXONDEYl2Dle0OnDzO5EKvjAXMT0B67XXi0+5N5KpEFsUxnxN1WIaGwbBr7VlJle//xAOzrppjWzylRnJK6DI1b1AD2dSvdNGod8RvQLvMKhSEw3HI0xn6cYFlSNoGwlIB7zeo47SkI3CLHfUHQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR21MB0836.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac76835d-6e78-4b2f-3dbb-08d833db9039
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 16:22:18.1430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZEGv1mpi7ESq1HTGL6nKIubZaDPhylpaazWOj1bu4UoNizO5KkU3lzHHMgVr5kSQ4fS6uiyx+9pfjvuCfXX+Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0771
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

T2sgYXQgbGVhc3QgdXNlIHRoZSByYXRlbGltaXQgZm9ybSBvZiBrZXJuZWwgbG9nZ2luZy4NCg0K
TmV0ZGV2X2Vycl9yYXRlbGltaXRlZC4uLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
RnJvbTogQW5kcmVzIEJlbHRyYW4gPGxrbWxhYmVsdEBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVz
ZGF5LCBKdWx5IDI5LCAyMDIwIDk6MTAgQU0NClRvOiBTdGVwaGVuIEhlbW1pbmdlciA8c3RoZW1t
aW5AbWljcm9zb2Z0LmNvbT4NCkNjOiBLWSBTcmluaXZhc2FuIDxreXNAbWljcm9zb2Z0LmNvbT47
IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+OyBXZWkgTGl1IDx3ZWkubGl1
QGtlcm5lbC5vcmc+OyBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOyBNaWNoYWVsIEtlbGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT47
IEFuZHJlYSBQYXJyaSA8cGFycmkuYW5kcmVhQGdtYWlsLmNvbT47IFNhcnVoYW4gS2FyYWRlbWly
IDxza2FyYWRlQG1pY3Jvc29mdC5jb20+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBodl91dGlsczog
QWRkIHZhbGlkYXRpb24gZm9yIHVudHJ1c3RlZCBIeXBlci1WIHZhbHVlcw0KDQpPbiBUdWUsIEp1
bCAyOCwgMjAyMCBhdCA1OjA0IFBNIFN0ZXBoZW4gSGVtbWluZ2VyDQo8c3RoZW1taW5AbWljcm9z
b2Z0LmNvbT4gd3JvdGU6DQo+DQo+IFlvdSBtYXkgd2FudCB0byB1c2Ugb25lIG9mIHRoZSBtYWNy
b3MgdGhhdCBwcmludHMgdGhpcyBvbmNlIG9ubHkuDQo+IFRoaXMgaXMgYSAic2hvdWxkIG5ldmVy
IGhhcHBlbiIgdHlwZSBlcnJvciwgc28gaWYgc29tZXRoaW5nIGdvZXMgd3JvbmcgaXQgbWlnaHQg
aGFwcGVucyBzbyBtdWNoIHRoYXQgam91cm5hbC9zeXNsb2cgd291bGQgZ2V0IG92ZXJsb2FkZWQu
DQoNCkNlcnRhaW5seSwgcHJpbnRpbmcgZXJyb3IgbWVzc2FnZXMgb25jZSB3b3VsZCBiZSBpZGVh
bCBpZiB3ZSB3ZXJlIG9ubHkNCmRlYWxpbmcgd2l0aCBMaW51eCBrZXJuZWwgYnVncy4gQnV0IHVu
ZGVyIHRoZSBhc3N1bXB0aW9uIHRoYXQgSHlwZXItVg0KY2FuIHNlbmQgYm9ndXMgdmFsdWVzIGF0
IGFueSB0aW1lLCBJIHRoaW5rIGl0IHdvdWxkIGJlIGJldHRlciB0byBwcmludA0KZXJyb3IgbWVz
c2FnZXMgZXZlcnkgdGltZSBzbyB0aGF0IHdlIGFyZSBhd2FyZSBvZiBtYWxpY2lvdXMvZXJyb25l
b3VzDQpkYXRhIHNlbnQgYnkgdGhlIGhvc3QuDQo=
