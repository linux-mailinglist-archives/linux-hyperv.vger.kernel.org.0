Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C3234258A
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Mar 2021 19:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhCSS6X (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Mar 2021 14:58:23 -0400
Received: from mail-mw2nam10on2105.outbound.protection.outlook.com ([40.107.94.105]:9824
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230324AbhCSS6K (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Mar 2021 14:58:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qjfn+sQPZVWHJ8OTUmLpMwhT9n7Q0LuUyTClma7u4Zt5aAvnzM4CkN387arqFgqL3NnzVI9I1ZAnLqotYhM+FpBnybtxfHiPqG6NmbtMUS+abWyKODc0GedCLozNaIMCDBIPVXsD3l5hk8gPTDopwdAdgUjEWxOepvIF71Mr+seJnSHz9kvGY9gRUQ6vzio94TxqMLoYKXPXK21Zusw8xWxt2AyIxwyiqlGxEnYZHeH4b68XzLTUeAWr0AHWafLAAQWu+I0d1RWf3KEbFEcnP+K+sAk7DeZGCoIRreGE6G7246VussBsUPuD1HoDIwTzRvgF5NVZsB++2w8oP1XIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZwMEm4AdgB3mSWINEAQwpDuTCEi7Vp4AMDffJh1g9Q=;
 b=cja1oaGLV9P7YuDtHQs9jyTs/SucjJYjl25VHJljHKowO29+wt5cddIoVu5ZhLwAFTPA77AXw+ltnmqNqBq6G6jjdVfqOgbhKnELjEL+yJNTAj2NtLaNvFd41TsSvyY4ykKzcgp1f29a817GMyB5H/vn1Nu2waYA0VgEftYAgR0/ijmR83YQo2XDvybxhZ0eFhORULnKP0J8HyRoCnu+R+4wamK9nCZ3BvxKjTnIYxFqoHXNygGagFUrayQD5VyJr+kIX1kSR9P9EHFdy0X00gAbEN5FW613p9zKns1UgPMQrBaJxO82SghIuEFZJ9xt132NDp0Vl+BcPobz7pKXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZwMEm4AdgB3mSWINEAQwpDuTCEi7Vp4AMDffJh1g9Q=;
 b=hQbLNZdMLiMcNVSTNi1g19KD4MlbgT+Q4KXCyPRJbarH5Q/rWqiVihzlpxTr47jK/gwmXlbWINqdfdJq6MUVobtX+Xv45IfKWXfzRVzjjC7T0jJCAF2KKtCHlTht5IOnNx9qNxOoZ0AaHunwYXrGD0vvaD52GQwI7gjUqIIjWT4=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1921.namprd21.prod.outlook.com (2603:10b6:303:65::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.2; Fri, 19 Mar
 2021 18:58:09 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::cbc:735e:a6a5:8b9c%8]) with mapi id 15.20.3977.016; Fri, 19 Mar 2021
 18:58:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Ingo Molnar <mingo@kernel.org>, Xu Yihang <xuyihang@huawei.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH -next] x86: Fix unused variable 'hi'
Thread-Topic: [PATCH -next] x86: Fix unused variable 'hi'
Thread-Index: AQHXG8rtRbbwh+IncEeyWrDupji5AaqJmt6AgAIPfSA=
Date:   Fri, 19 Mar 2021 18:58:09 +0000
Message-ID: <MWHPR21MB1593B76BB230F7905328DFE4D7689@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210318074607.124663-1-xuyihang@huawei.com>
 <20210318112415.GA301630@gmail.com>
In-Reply-To: <20210318112415.GA301630@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-03-19T18:58:07Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2cfd5f07-0544-43b5-bee4-72e02212a9ba;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42d9d5c2-cc9a-4056-f301-08d8eb08f050
x-ms-traffictypediagnostic: MW4PR21MB1921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1921E5C7572FDA43439CB9B6D7689@MW4PR21MB1921.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4HJ3N3AUX7usGuCCSXALNZv/Fsua0IKrsTgumFvydPVJQ1+hHJGyalZkUX1lQv5DfUJXGzdRLCUfe8ciJjLiOPVu3Q8EbTr8P0uqUqRhQib6L/qiOa9oMlXf/t/ahPmZnDcjIiDB0ASjANHJEOCJlA1wSpf+78Mw0r3tgyg+JhtZIOmfqxBJEC/MJp0wV+hgCZab3I/M2z/o4eiOO5lKOledD7KiCrrYNPOZ4XBEhyqhzUxRE5qqfp6S9oLUln1PWn/fMAtmnVi8oftzCd4f+fxtVEUWGyxngyWNn5bNgLK5mYQrF93dbYtVCau7DIIpI/yE8xgecfg5WXkkVnvyEEe6TKtH+FvlZ3TZqvUYGVnyZBx/NkIiiTiPjf/XJT8ykrwYd3HSr+trqWAisXiTJTg3eE3kJkb7wMUC0/b2+LSuaU0jVdRnUjnmqjLvIcvUHuBot+wisueLpbmP9NVZrNGQ8kqo0QV6vb88DFpyb0nDcp6Kx4uJ+05XlGNmdZ/F2HB87nXVSBGtdiw1vew/dd5V+9xifoRC5XbEyxLN9B/mDEhP1aFkab43Jmc3o1qlLXTIAFM5V/D6DUBr7cquh2hb4K/YmGFgxCTZwIBe4mDgdhmYGufukxjUztW/8I0n/UDsesq04UxVkFzNAOmLyGWPyVTY6Gb9SlbXkOw56Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(66476007)(52536014)(86362001)(76116006)(7696005)(10290500003)(478600001)(2906002)(26005)(66556008)(82950400001)(83380400001)(6506007)(5660300002)(66946007)(64756008)(66446008)(8936002)(316002)(54906003)(8990500004)(55016002)(9686003)(8676002)(71200400001)(4326008)(38100700001)(82960400001)(186003)(33656002)(7416002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dGhRMy9vMGlaMzY2Mm9FbUFGZ3puWW9PUVZVN1hsZzFwZkxlTS9mOUZOcGtR?=
 =?utf-8?B?QjhYL29vdWdiZ083OXRUbkxkU1N2ZHBaUnlYY2pHVTZvTzBKQVJxRUdVSW9H?=
 =?utf-8?B?Y1RRWkdsQ3NoQXVvWHNRRjVPVXg2OUNUeUExMUUxWEdqUy9CcVJnU3BoVmdU?=
 =?utf-8?B?QVpnYlhBOEtNY1JtVklzcXpmSnVsQ3ArU2dvbXVVcXhUVzE5YmhIUmsySTAz?=
 =?utf-8?B?aXUzNjNNa28xSmZRcDNGQ05HTnVaWXlieTllVFdGZElvakhmdlY1c2NDd1pD?=
 =?utf-8?B?S3REKzRZQWtpSzRKakxybWRVU1FVM3JySW5ISTFYaGxTWmtZaisyR3R3N1Vu?=
 =?utf-8?B?aHMwbHIvcndKdG5PWWdkTHRyUE4vUDdmOENpTC9yeUp4NmlodW43L2NWL0Nk?=
 =?utf-8?B?Nm9wSjZUM3Y3U3NXWVR6T2ZkYTREaTlLb3ZlL3FYQkRNMFIydWRZQ01rcU9p?=
 =?utf-8?B?NUg3RmFwaTFhU2ZlaHFTZXZhMzVDOHljWko2S2NzbjVqMk5naGx3cjdRcll4?=
 =?utf-8?B?NEJ5U045akY1enFFT0VVRlplajZib1g3NWFEMmxMdkVTMUl5blE3WWcvTGw5?=
 =?utf-8?B?QXoyRDBxbzVlTW43QVRlMkFJd09mYm10eDBkeFBxbVBCWE9TNXRadmpBUlU0?=
 =?utf-8?B?c2FtWmVuYjNtdkltWlhNTjdvaWE2NjkvRGdXbGZvRzVMc3RHWHd3L2lxWjhW?=
 =?utf-8?B?L29pR25obTN0L0RaMjJqVTBicG1JVU5aZVVZWlJ2a3JTdGFwSTNNR3N0NmZE?=
 =?utf-8?B?RGFhWGlNbElYTjlHdUNHTDhKbFRHTHc4K1hEWSs1ejhJaElxTGl3TGsxRjVu?=
 =?utf-8?B?Yy9JYkxvbGcwWFUyMGdSZE95cGlGSDRkeFpRdXpSSlA2R1lITjI5RHBRL2Fa?=
 =?utf-8?B?dU9oVmkyTWE4VWN5Y2FLY3BlalU0QnhBSDA2c2IwZXNCYUVWUnRsQzFZRm5r?=
 =?utf-8?B?MCtCb3hJWVkwSDk0bDB3MnZoTjA0SHRDR1pIZ0dXYmIyRkJTK1V6WkFrSGlI?=
 =?utf-8?B?V3NGZHNqNFEyWWdNcWRuc2J4R3FkL0FnNFRQY1pnYTB4R3BDdDJtRHpTYVo2?=
 =?utf-8?B?MkNIc3lVTXVobWJSNFlKbFBRMjhUUEcyM1hPRWNrbVptdWtuR2pzaTNWNkhw?=
 =?utf-8?B?WERESkhsbUl2YWNpdzMvYUFoUktQT3hwbkExMnJMTVhweHBoaXlkOS81SDdV?=
 =?utf-8?B?SU0vTXVIZk9KZDhucm11U2RwcktlTzd5Z2NmVVAwV20ycG9QYkdyN0E5cXRJ?=
 =?utf-8?B?WlFGV3BvSUZBMk1PQnFtSk4vVVJmK05uS1JHYjVwZnNkc0ZjRWVNLzgxK01o?=
 =?utf-8?B?emJuN1dUZWpxSkJZT05JQWZFS3MzNVlVSFhqR0RIYnZLVVlWdldoOXZzT1hP?=
 =?utf-8?B?bFBCQ2NiV2YzeXpkWjFGNWEvdnhzRE44d3J3S2cxK2dCOW5xVjBWQk1QSDVE?=
 =?utf-8?B?WXpwVmJ1Mmp0eDc4QitoelMxSllQY09ja3RSYThZZTkwSXVoOUFveW5VR01U?=
 =?utf-8?B?bVcyMVN1SVNqMy83am9uYzhiMUM4eUxDSGhheHdEajA2Zmx6aUpIQlFPL1JU?=
 =?utf-8?B?dkVpRmJlY08ySEl6dkdhaDF6d3QrM0hndFdjVnhYRThUM3Z2ZHdwRURJR2E1?=
 =?utf-8?B?SG5NZUVGb0NDOGVzNUFGSVMyOVdzVXU1RWJHbWhlajJqbVVwenI4WkI2WDhQ?=
 =?utf-8?B?cHhmQldPMHRGNDlxUGd6UGRSWmoyZFVJbzNMNG9ReS9BNTJhUU1GeTBKMDJR?=
 =?utf-8?Q?JL/PjJtFkZk8jTEke/fDxabxCbxu0Il/c6LbEcO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d9d5c2-cc9a-4056-f301-08d8eb08f050
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2021 18:58:09.5778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Goy8vj+FAtWOxJUyQG0oCEU4XgOcul3Rxv6emAC76r2tp+qo+pNGXY7gs3kgPWw0t8hrs6wwK3LgfMARvFr+9xDOQMxaWjIaIXqyrcaxnvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1921
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogSW5nbyBNb2xuYXIgPG1pbmdvLmtlcm5lbC5vcmdAZ21haWwuY29tPiAgU2VudDogVGh1
cnNkYXksIE1hcmNoIDE4LCAyMDIxIDQ6MjQgQU0NCj4gDQo+ICogWHUgWWloYW5nIDx4dXlpaGFu
Z0BodWF3ZWkuY29tPiB3cm90ZToNCj4gDQo+ID4gRml4ZXMgdGhlIGZvbGxvd2luZyBXPTEga2Vy
bmVsIGJ1aWxkIHdhcm5pbmcocyk6DQo+ID4gYXJjaC94ODYvaHlwZXJ2L2h2X2FwaWMuYzo1ODox
NTogd2FybmluZzogdmFyaWFibGUg4oCYaGnigJkgc2V0IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQt
YnV0LQ0KPiBzZXQtdmFyaWFibGVdDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogSHVsayBSb2JvdCA8
aHVsa2NpQGh1YXdlaS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWHUgWWloYW5nIDx4dXlpaGFu
Z0BodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9oeXBlcnYvaHZfYXBpYy5jIHwg
MyArKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9odl9hcGljLmMgYi9hcmNo
L3g4Ni9oeXBlcnYvaHZfYXBpYy5jDQo+ID4gaW5kZXggMjg0ZTczNjYxYTE4Li5jMGIwYTU3NzRm
MzEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC94ODYvaHlwZXJ2L2h2X2FwaWMuYw0KPiA+ICsrKyBi
L2FyY2gveDg2L2h5cGVydi9odl9hcGljLmMNCj4gPiBAQCAtNTUsNyArNTUsOCBAQCBzdGF0aWMg
dm9pZCBodl9hcGljX2ljcl93cml0ZSh1MzIgbG93LCB1MzIgaWQpDQo+ID4NCj4gPiAgc3RhdGlj
IHUzMiBodl9hcGljX3JlYWQodTMyIHJlZykNCj4gPiAgew0KPiA+IC0JdTMyIHJlZ192YWwsIGhp
Ow0KPiA+ICsJdTMyIGhpIF9fbWF5YmVfdW51c2VkOw0KPiA+ICsJdTMyIHJlZ192YWw7DQo+ID4N
Cj4gPiAgCXN3aXRjaCAocmVnKSB7DQo+ID4gIAljYXNlIEFQSUNfRU9JOg0KPiANCj4gV2h5IGFu
ZCB1bmRlciB3aGF0IGNvbmZpZyBkb2VzIHRoaXMgZnVuY3Rpb24gdHJpZ2dlciB0aGUgd2Fybmlu
Zz8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IAlJbmdvDQoNClRoZSB3YXJuaW5nIHNob3VsZCB0cmln
Z2VyIGlmIENPTkZJR19IWVBFUlYgaXMgIm0iIG9yICJ5IiwgYW5kIFc9MQ0KaXMgc2VsZWN0ZWQu
ICBUaGUgdmFyaWFibGUgaXMgaW5kZWVkIHNldCBidXQgbm90IHVzZWQgYmVjYXVzZSBvbmx5IHRo
ZQ0KbG93IG9yZGVyIDMyIGJpdHMgb2YgdGhlIHN5bnRoZXRpYyBNU1IgYXJlIHJlbGV2YW50LCBi
dXQgcmRtc3IoKSByZXR1cm5zDQpib3RoIHRoZSBsb3cgMzIgYW5kIHRoZSBoaWdoIDMyIGJpdHMu
DQoNCk1pY2hhZWwNCg==
