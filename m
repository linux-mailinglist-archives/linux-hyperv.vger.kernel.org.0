Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308B86BEA5C
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 14:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjCQNnP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 09:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjCQNnN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 09:43:13 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020015.outbound.protection.outlook.com [52.101.56.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECEC33473;
        Fri, 17 Mar 2023 06:43:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RXDQe55fMztjgtTLWX38oSz2zDoWizE0s4ShVJoq7gwjhTHOOSBQhEekSv2dZdBKhR1r6RWQ7jVppa7xdpYtNDssHTKFcvaZIo22bE/FRMnLS+Ud2nhug3NL+EDKP3FccvhOMbPeKz8gKSbH1PK82SQJBxrATegLb0DaTy9lxH3kdMEZwdGwIKpFSPWCW8DfcMLkiYPA++o7vefBOVQaSrkzHqsoCZt2wRyolS/D0/Xb9fW8PfbYQHt5B8oUhFZkoywgqKgTjXK8XT1G3hUTRE8uVM1lJbeHYhFcdH735QtE/hpGNPn8Tb+w6p8QeBDQPmVUTnVy/QebNsV+1tYoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t/DUGZtKBqdPVnMN2laKxAatKUr887wBLAjY0ao7tM=;
 b=Z+liVLK54W3XF0CUzmEvFf5A3JU5fif16OtXdYRhMXn8nzCGXVr87ArqNgR/1En7YqZvWI8MOXJ9a1jGl3U/3RcTAP2MtDUnWxbZI6rmu73EKX4hyMcWUrVv52ASMNvxKbL3kptqmwXJliIdvOhAVk1LdO3qfTtbyTYpF/XBUboPtuzmTgtm59NVDafP5uqHMoznMA5Zk5WwZYbe/P2PcZ9HD8Lp0nZbZmxSWmz1xZsXCWjZER39vUqxw62MYH93tnIgCzk/B8kzfVQkD4L7fMiAH9MakE8S9RWA+CbwitdZCFQNq1PC2GusOWOAEgMHtqgeQAh8t/265H+ZQJ9ozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t/DUGZtKBqdPVnMN2laKxAatKUr887wBLAjY0ao7tM=;
 b=iayRnwKnG6YVuYYLbuEXi3ROfH0lNk394Z0e11NUeZaKaLV2vipxn1Ka4/WYpC+1zM/kuBZkq+SW9bLAeQEKLv9S4ftJSchXoBd0Erp3Z+V2nMbt5eVbz3cautqZKQoyH/7xNKx9cqVz+FQHcFZgSLVZ60tHxswUvxF/PKDn/2Q=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3922.namprd21.prod.outlook.com (2603:10b6:510:24c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 13:43:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%6]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 13:43:09 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Thread-Topic: [RFC PATCH] hyperv-tlfs: Change shared HV_REGISTER_* defines to
 HV_SYNTHETIC_REG_*
Thread-Index: AQHZUTma1YX9/OQzMkiQz3mMWYqOma70Wb1QgATkhYCAAEg44IAC+ROAgAKKJhA=
Date:   Fri, 17 Mar 2023 13:43:09 +0000
Message-ID: <BYAPR21MB16888B1E88318BCCD5685E89D7BD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1678223570-25242-1-git-send-email-nunodasneves@linux.microsoft.com>
 <BYAPR21MB16889A9D76888A485D7BB19FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <e777ad2e-0bad-3a04-b831-ebd07edb7fc3@linux.microsoft.com>
 <BYAPR21MB1688FBD79441A4D75BBDAB24D7BE9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <726a61de-61e6-18c7-e1f2-6dd8a7630d38@linux.microsoft.com>
In-Reply-To: <726a61de-61e6-18c7-e1f2-6dd8a7630d38@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fb27fca8-39ef-405d-9682-f7e7b9126278;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-17T13:40:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3922:EE_
x-ms-office365-filtering-correlation-id: b67468d2-f84f-4f7d-d34a-08db26ed8b99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SAfgAor30bxMa7MTZ/azRSDcuJ7vHYn+yPA829yR0zuDq94SIIbVt/MyXyvKo6XtmLHdThWVFkI0eFC0Ybcsj3yXB/TJIRAQO8neIi9A1DUbQQtRRos6pDbFpoCP66ZNH/B94oC/42xn5O14Q/eI99B1pChmPUL6ZexmOFG3d6YutVx7qqpAyn9vlnU2XVaan4Tm35Q62pY3cn6aMfsoFXiWpSOHe0PxRnnWeoA6Viko5CLEN/57MMHIgJ4z124Ste91Q2KwKgsVtkK9u2jZhIGtrcKTyUJLpBvk9dyoRtOTvvc0IdqCxlcG/BQDGNlwPIJyqUhjFLcaTet5yWTJdiOPWL3YqFPqklO+4hVb4nhtk59Wi67ZCyyDCbIzU2m430KpdrNiXxkhyzo6MINgsOQ7/o2/9ZdI8HaVouWuKCUmUJ/cgj9sPCHutHNT+HEMbnUuDkxkl0C/QCyGsrNRABAO7Dkc2Vgr4xm2mWYPH53ks04YZUdBL1faetA3sduDCJv4WvChQBhZBclb/cjxAuOWzVQfaZm5qpPraZ/Vla8YTSAf/RL70d38yJghNdFU/NGwXk5swmEYFGcGqvOuu8qf9GilDjdvg2ROAKQVY2n/AOW13fevPLL97neIVoOlShAIUj5cjEpaUHwEDrrOYb3GRoNowb+vNKIkWlV/cmaIK9dZvGKFqEs2B2hGjCs+Gbr8a2zybob954Na2/CSQoo0CYEgaaEw+84yeetdO5BHwuDloQRUgPGF4pczDJMw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(4326008)(41300700001)(66476007)(8676002)(64756008)(66556008)(66446008)(76116006)(66946007)(83380400001)(5660300002)(8936002)(26005)(52536014)(6506007)(186003)(9686003)(54906003)(110136005)(316002)(71200400001)(478600001)(7696005)(10290500003)(2906002)(38070700005)(53546011)(33656002)(55016003)(82950400001)(8990500004)(82960400001)(38100700002)(122000001)(66899018)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRCK3UwMWVOV0EzaFFySWlsOE5MNTJVMk5idlpud1NpeVlqR0s3U1pPeWhv?=
 =?utf-8?B?MUFodThvYVpsUld2bWZyLzg1dHorUzBGL2t2Qy9rMmtrUzliaVBtN0xCeGEx?=
 =?utf-8?B?dkYwNEJTTFdmUmVRZGdXSFpZZFoxYzFCWW1nUWVBNUVJckhKQkJsY2IvQ0U1?=
 =?utf-8?B?ZXZ4dVBBZHJtV094dTI4OUNLYnJCWXpTMjlvYStvQkNaTlhHaDJEZWVHbUM5?=
 =?utf-8?B?QWJHbXdYOVhXZ1JZdXFoUHFGZTRVdVVtVG5mV1pOVElPci9MZDEvZ3drcENG?=
 =?utf-8?B?dE0rTnZkMTdsZzNSS3BHU0RNcjc1RTBrMlVMR0Y0dDkvaW95cEF0cXFTK0x0?=
 =?utf-8?B?N0lmNjBWZ0RDc1AzNzNJMmxzNytJRGhqK2lXeUJ3dXRxMGVVVzlYSVlMT2Vi?=
 =?utf-8?B?N3V5a0JCTzA4UmRnRi9ScVFqNkRQMWJBbFZCVC9ZbnFGWmtpYXpaeCtraFRQ?=
 =?utf-8?B?b091U1FyTkdQdm8weHRZc0Nyb0hoZDAzZTdiUHJoRmZhcDZrUlJORmJpV1pv?=
 =?utf-8?B?Rm02WW9GbXNtUW9oenpZeDkzbnpaL1Z2Z25uU1JTQ3RpRzRnTmxnL2xyT3Js?=
 =?utf-8?B?Y2k2T0RySUM4azJ6Q3E3akJsUG54SkNWaXNWUUk0Z1FjNENnbkc2ZVZWTk9P?=
 =?utf-8?B?RmNDSlZzOXdEdFhKY3RqTE0xam1pbGhjaDdNNFBBWkZGZStQc3p0dVI2WjVs?=
 =?utf-8?B?YXJ3NDhpdXE1ZGF0ekNsc3dkVVlXRVRuZitXLy8vbDRYRDRjOUI2K2ZIZGc2?=
 =?utf-8?B?WDNDOHY1MHJkQ1FPRHNRUnE3Rjh5R1JXRU5XbWxvS0N4L1pERjdCMSthS05Y?=
 =?utf-8?B?Y0lJVWFEbmxsM3FodDNHakJzc2VpdC83S2owN2x5cGNDTHpLVE50bTRlZXhK?=
 =?utf-8?B?UDh4TlFueitlK3R1N0pwWGJqTllkZVRFaUZSdlhMQkc3c1Z2SnVZaW93eEk1?=
 =?utf-8?B?Tmo3aW0zdExEaG45UllEay9vK1ZVWHZNM1NWa01DVi9iWEFGKy9IazhhVlQ1?=
 =?utf-8?B?THJIVlNVNzJFb2FuUWI1dzYxOTNSbnhqMHhXZlE1cmtObWhidzRTdURobHcw?=
 =?utf-8?B?MlZsTUdEK3lxd0pyeWNMRzE1c28weXRURzF0RW1Wdnh5K1BqRERiUEVTNmJm?=
 =?utf-8?B?RDM2M05vWVdBMUFydnlPa08zOHRlM0daUWxjdGJXTTBrYjRsS3QzelNZdjNM?=
 =?utf-8?B?VXI0Y2lzaVIxUStacGxpRUpyS0tZZWc5OXR3d0RwZHVrVTl4aG1VS0tRMXpy?=
 =?utf-8?B?VEpMVVVPVnNqaTlhNURYclg2M3plblZ4VnJ6dFRMcEo0QkZDZm1EbllHMEZh?=
 =?utf-8?B?ZVJTcEVnSS8zUlAzS0xMd3hjTm85RXVINHVSSzF2Y0RXbGlwSkFndW40bFZp?=
 =?utf-8?B?OEsyeG54eUVpMjJUTXJzMnJjQmYrY2F1Q2JRSU9zQWV2Q2NFaXdUbVFTVzdk?=
 =?utf-8?B?MUZPdlhFa2hqVDJwMjRKV0tQTm1PVnlKM3c0N21VSEJ4L1N0VXhmbWREdzVl?=
 =?utf-8?B?R2hrN2hadHZDb2ttaWs4MXUyYzN5VzhxM1U3L3F3bDJVc3NOenN5WHBvS3RE?=
 =?utf-8?B?bWt4aXRrZkl3b2hBczlaK3JySjRtVXhBQjJsSVFRMHZJVkRURG0zYUgyVFNF?=
 =?utf-8?B?ZUNNS29MaHNkcDRQL0syeEtsT2ZtTjVEdFFMbHZ1anRvS2szTUtiQjJSZ0J0?=
 =?utf-8?B?K25ERzBCNlZtQWVlcmh1RnZIK1MzYmZJeVlJNmRlWmQ0eEk0UkNnblB3QjQ0?=
 =?utf-8?B?VzFkVjUxTzZ5L1RLNGpvcVFHdkZrcnkyWFRzZXVRcnd2R1BtMW42aE5xTEdD?=
 =?utf-8?B?eDNlcU11U2RqbXpFYld5ZmZJNm1DNDhFb2E2bVhtdmZ2VHZ4dXk0aHh6RHlZ?=
 =?utf-8?B?T2MzcWNTQ25WcHRXbWFTYnpOVCswNEhrNzNzTXJPaEpZNDJ5QUJ4TTREN0hs?=
 =?utf-8?B?aFhwSW5pcEduaTVtY1FuVHlEZXRiRXdlR2JOR3FodEhlUFA3aTllRTBGV2tQ?=
 =?utf-8?B?akxabFprK0lyMXp5d2hwdHR0bUFtWEpoUmhWSWFBcjFnQkswc3NPRGVIZDB6?=
 =?utf-8?B?ZmdVQVJhc3M3M1JqK2szNVErM1R4MXFNZGFhSDBzVDFrYWVGOFNSZ09LYjND?=
 =?utf-8?B?Wlc3Vk5Sd0hPTmFNcU9MZVZ5UTMxcEhYTHRLa0I2bnNQMDNTcWFybi8weGF1?=
 =?utf-8?B?UHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b67468d2-f84f-4f7d-d34a-08db26ed8b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 13:43:09.4155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bgb8OYk1Mitx0S0xhjIsQ1NyyCuytZRreSYn3sCBRdg8TW0ZVTt/ovbB0e9t0Z9Y5k0d6Sr8VV9A4M+XXkVChYSiFn4kek2f6DU8YGzTwLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBXZWRuZXNkYXksIE1hcmNoIDE1LCAyMDIzIDM6NTQgUE0NCj4gDQo+IE9uIDMvMTMvMjAy
MyA2OjU2IFBNLCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IEZyb206IE51bm8g
RGFzIE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogTW9uZGF5
LCBNYXJjaA0KPiAxMywgMjAyMyAyOjExIFBNDQo+ID4+DQo+ID4+IE9uIDMvMTAvMjAyMyAxMToz
MCBBTSwgTWljaGFlbCBLZWxsZXkgKExJTlVYKSB3cm90ZToNCj4gPj4+IEZyb206IE51bm8gRGFz
IE5ldmVzIDxudW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogVHVlc2RheSwg
TWFyY2ggNywNCj4gPj4gMjAyMyAxOjEzIFBNDQo+ID4+Pj4NCj4gPj4+PiBJbiB4ODYgaHlwZXJ2
LXRsZnMsIEhWX1JFR0lTVEVSXyBwcmVmaXggaXMgdXNlZCB0byBpbmRpY2F0ZSBNU1JzDQo+ID4+
Pj4gYWNjZXNzZWQgdmlhIHJkbXNybC93cm1zcmwuIEJ1dCBpbiBBUk02NCwgSFZfUkVHSVNURVJf
IGluc3RlYWQgaW5kaWNhdGVzDQo+ID4+Pj4gVlAgcmVnaXN0ZXJzIGFjY2Vzc2VkIHZpYSBnZXQv
c2V0IHZwIHJlZ2lzdGVycyBoeXBlcmNhbGwuDQo+ID4+Pj4NCj4gPj4+PiBUaGlzIGlzIGR1ZSB0
byBIVl9SRUdJU1RFUl8qIG5hbWVzIGJlaW5nIHVzZWQgYnkgaHZfc2V0L2dldF9yZWdpc3RlciwN
Cj4gPj4+PiB3aXRoIHRoZSBhcmNoLXNwZWNpZmljIHZlcnNpb24gZGVsZWdhdGluZyB0byB0aGUg
YXBwcm9wcmlhdGUgbWVjaGFuaXNtLg0KPiA+Pj4+DQo+ID4+Pj4gVGhlIHByb2JsZW0gaXMsIHVz
aW5nIHByZWZpeCBIVl9SRUdJU1RFUl8gZm9yIE1TUnMgd2lsbCBjb25mbGljdCB3aXRoDQo+ID4+
Pj4gVlAgcmVnaXN0ZXJzIHdoZW4gdGhleSBhcmUgaW50cm9kdWNlZCBmb3IgeDg2IGluIGZ1dHVy
ZS4NCj4gPj4+Pg0KPiA+Pj4+IFRoaXMgcGF0Y2ggc29sdmVzIHRoZSBpc3N1ZSBieToNCj4gPj4+
Pg0KPiA+Pj4+IDEuIERlZmluaW5nIGFsbCB0aGUgeDg2IE1TUnMgd2l0aCBhIGNvbnNpc3RlbnQg
cHJlZml4OiBIVl9YNjRfTVNSXy4NCj4gPj4+PiAgICBUaGlzIGlzIHNvIEhWX1JFR0lTVEVSXyBj
YW4gYmUgcmVzZXJ2ZWQgZm9yIFZQIHJlZ2lzdGVycy4NCj4gPj4+Pg0KPiA+Pj4+IDIuIENoYW5n
ZSB0aGUgbm9uLWFyY2gtc3BlY2lmaWMgYWxpYXMgdXNlZCBieSBodl9zZXQvZ2V0X3JlZ2lzdGVy
IHRvDQo+ID4+Pj4gICAgSFZfU1lOVEhFVElDX1JFRy4NCj4gPj4+DQo+ID4+PiBJIGRlZmluaXRl
bHkgbWVzc2VkIHRoaXMgdXAgd2hlbiBJIGZpcnN0IGRpZCB0aGUgQVJNNjQgc3VwcG9ydCBhDQo+
ID4+PiBmZXcgeWVhcnMgYmFjay4gIDotKCAgICBUaGlzIGlzIGEgbmVjZXNzYXJ5IGZpeC4NCj4g
Pj4+DQo+ID4+PiBXaGF0IGFib3V0IGtlZXBpbmcgSFZfUkVHSVNURVJfIGFzIHRoZSBwcmVmaXgg
Zm9yIHRoZSBhcmNoaXRlY3R1cmUNCj4gPj4+IGluZGVwZW5kZW50IGFsaWFzLCBhbmQgY3JlYXRp
bmcgYSBuZXcgcHJlZml4IGZvciB0aGUgSHlwZXItViByZWdpc3Rlcg0KPiA+Pj4gZGVmaW5pdGlv
bj8gIFRoaXMgd291bGQgYWxsb3cgdGhlIGV4aXN0aW5nIGh2X2dldC9zZXRfcmVnaXN0ZXIoKQ0K
PiA+Pj4gaW52b2NhdGlvbnMgdG8gcmVtYWluIHVuY2hhbmdlZCwgYW5kIGVsaW1pbmF0ZXMgdGhl
IGNvZGUgY2h1cm4NCj4gPj4+IGluIHRoZSBhcmNoIGluZGVwZW5kZW50IGNvZGUuDQo+ID4+Pj4g
VGhlIEhWX1g2NF9NU1JfIHByZWZpeCBpcyBkZWZpbml0ZWx5IGdvb2QgZm9yIHRoZSBNU1IgYWRk
cmVzc2VzLA0KPiA+Pj4gZXNwZWNpYWxseSBzaW5jZSBhIGxvdCBvZiBkZWZpbml0aW9ucyB0aGF0
IGFyZSB4ODYveDY0IG9ubHkgYXJlIHN0aWxsIGluIHVzZS4NCj4gPj4+IFRoZW4gcGVyaGFwcyB1
c2UgSFZfSFlQX1JFR18gb3Igc29tZXRoaW5nIHNpbWlsYXIgZm9yIHRoZSBIeXBlci1WDQo+ID4+
PiByZWdpc3RlciBkZWZpbml0aW9uLg0KPiA+Pg0KPiA+PiBUaGlzIGNvdWxkIHdvcmsuDQo+ID4+
DQo+ID4+IElkZWFsbHksIHdlIHdvdWxkIHVzZSBIVl9SRUdJU1RFUl8gZm9yIHRoZSB2cCByZWdp
c3RlcnMgYXMgaXQncyBhIGRpcmVjdCBtYXRjaA0KPiA+PiB0byB0aGUgbmFtZSBpbiBIeXBlclYg
ZS5nLiBIdlJlZ2lzdGVyVnBJbmRleC0+IEhWX1JFR0lTVEVSX1ZQX0lOREVYDQo+ID4NCj4gPiBZ
b3UgbWFrZSBhIGdvb2QgcG9pbnQuDQo+ID4NCj4gPj4NCj4gPj4gSG93ZXZlciBpZiB5b3UgdGhp
bmsgaXQncyBiZXR0ZXIgdG8gcmVkdWNlIGNodXJuIGFuZCBnbyB3aXRoIGEgZGlmZmVyZW50DQo+
ID4+IG5hbWUgdGhlbiB0aGF0J3MgZmluZSBieSBtZS4NCj4gPg0KPiA+IEkgd2FzIHNwZWNpZmlj
YWxseSB0aGlua2luZyBhYm91dCAzIGxhcmdlLWlzaCBwYXRjaCBzZXRzIGZvciBDb25maWRlbnRp
YWwgVk1zDQo+ID4gdGhhdCB3ZSBoYXZlIHBlbmRpbmcuICBUaGUgQ29uZmlkZW50aWFsIFZNIHBh
dGNoZXMgaGF2ZSB2YXJpb3VzIGNoYW5nZXMNCj4gPiB0byB0aGUgc3luaWMgY29kZSBpbiBodi5j
IHNvIGl0IG92ZXJsYXBzIHdpdGggeW91ciBjaGFuZ2VzIHRvIHRoZSByZWdpc3Rlcg0KPiA+IG5h
bWluZy4gIFRoZSBDb25maWRlbnRpYWwgVk0gcGF0Y2hlcyBuZWVkIHRvIGJlIGJhY2twb3J0ZWQg
dG8gZWFybGllcg0KPiA+IExpbnV4IGtlcm5lbCB2ZXJzaW9ucywgYW5kIEkgd2FzIHRyeWluZyB0
byBhdm9pZCB1bnJlbGF0ZWQgY2h1cm4gdG8gZWFzZQ0KPiA+IHRoZSBiYWNrcG9ydCBwcm9jZXNz
LiAgIEhvdyB1cmdlbnQgaXMgZml4aW5nIHRoaXMgcmVnaXN0ZXIgbmFtaW5nIHByb2JsZW0/DQo+
ID4gSWYgaXQgY291bGQgZ28gYWZ0ZXIgdGhlIENvbmZpZGVudGlhbCBWTSBwYXRjaGVzLCB0aGVu
IHRoZXJlJ3MgbGVzcyBjaHVybiBmb3INCj4gPiB0aGUgYmFja3BvcnRzLg0KPiA+DQo+IA0KPiBJ
dCBpcyBub3QgdXJnZW50LCBidXQgSSB3YW50ZWQgZmVlZGJhY2sgb24gdGhlIGFwcHJvYWNoIGJl
Y2F1c2UgdGhpcyBuZWVkcyB0byBiZQ0KPiBmaXhlZCBpbiBzb21lIHdheSBmb3IgdGhlIC9kZXYv
bXNodiBkcml2ZXIgd2hpY2ggYWRkcyBhbGwgdGhlIHZwIHJlZ2lzdGVyIG5hbWVzLA0KPiBhbmQg
SSB3YXMgaG9waW5nIHRvIHVzZSBIVl9SRUdJU1RFUl8gZm9yIHRob3NlLg0KPiANCj4gPiBCdXQg
aW4gdGhlIGdyYW5kIHNjaGVtZSBvZiB0aGluZ3MsIHdlIGNhbiBkZWFsIHdpdGggdGhlIGNodXJu
LiAgSXQncyBqdXN0DQo+ID4gc29tZSBtYW51YWwgd29yayB0aGF0IGlzbid0IGhhcmQuICBOZXQs
IEknbSBPSyB3aXRoIGVpdGhlciBhcHByb2FjaC4NCj4gPg0KPiANCj4gSW4gdGhhdCBjYXNlLCBJ
J2QgcHJlZmVyIHRvIGdvIHdpdGggbXkgb3JpZ2luYWwgaW50ZW50aW9uIG9mIGNoYW5naW5nIHRo
ZQ0KPiBtZWFuaW5nIG9mIEhWX1JFR0lTVEVSXyB0byBiZSB0aGUgdnAgcmVnaXN0ZXJzLCBhbmQg
YWRkaW5nIHRoZSBnZW5lcmljDQo+IEhWX1NZTlRIRVRJQ19SRUcgKG9yIGEgc2hvcnRlciBuYW1l
IGFzIGJlbG93KS4NCg0KRmFpciBlbm91Z2guDQoNCj4gDQo+IEJ1dCwgbWVyZ2luZyB0aGlzIGNo
YW5nZSBjYW4gaW5kZWVkIHdhaXQgLSBJIGNhbiBpbmNsdWRlIGl0IGluIHRoZSAvZGV2L21zaHYN
Cj4gcGF0Y2ggc2VyaWVzLiBTaW5jZSB0aGF0IHdpbGwgdGFrZSBzb21lIHRpbWUgdG8gcmV2aWV3
L2l0ZXJhdGUgb24sIGl0J3MgbGlrZWx5DQo+IHRoaXMgY2hhbmdlIHdvdWxkbid0IGFjdHVhbGx5
IGJlIG1lcmdlZCBmb3Igc29tZSB0aW1lLg0KPiANCj4gPj4NCj4gPj4gSFZfSFlQX1JFR18gaXMg
b2ssIHRob3VnaCBtYXliZSBIVl9WUF9SRUdfIGlzIGEgYml0IG1vcmUgaW5mb3JtYXRpdmU/DQo+
ID4+ICJWUF9SRUciIGluZGljYXRpbmcgaXQncyByZWxldmFudCB0byBIVkNBTExfR0VUL1NFVF9W
UF9SRUdJU1RFUlMuDQo+ID4NCj4gPiBZZXMsIEhWX1ZQX1JFR18gaXMgZ29vZCBhcyB0aGUgcmVn
aXN0ZXIgcHJlZml4IGlmIHlvdSBkZWNpZGUgdG8ga2VlcA0KPiA+IEhWX1JFR0lTVEVSXyBhcyB0
aGUgYXJjaGl0ZWN0dXJlIGluZGVwZW5kZW50IHByZWZpeC4NCj4gPg0KPiA+Pg0KPiA+Pj4NCj4g
Pj4+IElmIHlvdSBkb24ndCBsaWtlIHRoYXQgc3VnZ2VzdGlvbiwgSSB3b25kZXIgaWYgdGhlIEhW
X1NZTlRIRVRJQ19SRUdfDQo+ID4+PiBwcmVmaXggY291bGQgYmUgc2hvcnRlbmVkIHRvIGhlbHAg
YXZvaWQgbGluZSBsZW5ndGggcHJvYmxlbXMuICBNYXliZQ0KPiA+Pj4gSFZfU1lOUkVHXyBvciBI
Vl9TWU5fUkVHXyA/DQo+IA0KPiANCj4gVGhpcyBpcyBhIGdvb2QgaWRlYS4gSSdtIGZpbmUgd2l0
aCBlaXRoZXIsIHdpbGwgZ28gd2l0aCBIVl9TWU5fUkVHXyBpZiB5b3UNCj4gZG9uJ3QgaGF2ZSBh
IHByZWZlcmVuY2UuDQoNCk9LDQoNCj4gRG8geW91IHRoaW5rIGl0IGlzIG5lY2Vzc2FyeSBvciB3
b3J0aHdoaWxlIHRvIGFsc28gcmVuYW1lIGh2X2dldC9zZXRfcmVnaXN0ZXINCj4gdG8gaHZfZ2V0
L3NldF9zeW5fcmVnPw0KDQpJIGRvbid0IGhhdmUgYSBzdHJvbmcgcHJlZmVyZW5jZSBlaXRoZXIg
d2F5LiAgIFlvdXIgY2hvaWNlLg0KDQpNaWNoYWVsDQo=
