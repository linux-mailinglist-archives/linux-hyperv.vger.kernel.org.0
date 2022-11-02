Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B256172EA
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Nov 2022 00:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKBXlI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Nov 2022 19:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiKBXkp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Nov 2022 19:40:45 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2107.outbound.protection.outlook.com [40.107.96.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2231213FA9;
        Wed,  2 Nov 2022 16:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbPqRQROVlHqGf5OxKIvJm2Jf1R7CrSSLP0C7fgj5u15IjniQHIn46GjnEPd5mrBY3c0w29FPgjVPrLvYROf0hyKqlYS4wlYSQCQYpjzGY+jR7nk15IEi0uhb7JqIWPBijGcwP5HunGhvnE+YK5vp2LhBFMqg9x3SAFSltu+JncQXFU2op6dqN3MhaYsAgWMLINztIWinw5tItYt0UFJ6slvR1f/puZaSebl1xTx3JigiBDJGlrzDNm5m8bDrKiJLtPkFhJSkPR79dAIzKiAhDnt36X8euGshjzdCjepsywe28ytAupUJQn20wd7KIZHlHehRiDRDs4ALnX6VuUp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt4SC42JzwBOzwr8ZbRMvqATYWE+L6lExiziI7pk+2o=;
 b=DoQlOon72QXFGX12L03JheLWyiZPQ27DGT8b/2ZmyFdYhdir/91N+oTP44GOJSs6/Xic91mYB0uXzRYDi9Lp+OyPJdkp+fmp0PETZE6jfJVdw/dPC+1VY0Yii7ys4EwCEleuLbddDrwMwwn7sN4jsTAyFzmw2gfiWuN+9CJmjDm3UOSjkboRcwZC+POW8aEsrJpQ6peC6vNInuEMeXYobRYksez/VVswk9lFetRZlbD8UYRZ9Rvh6c8w6z6BzktthwfQXnn2rLC8QK6k3NqvkaK3hJbJgkMHIejYqtoUkJjJu/KWY6uvZ5YIQJ5Dme5QHXTIc5/B0HpKb9Xy3bUfVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bt4SC42JzwBOzwr8ZbRMvqATYWE+L6lExiziI7pk+2o=;
 b=cepw9qyHF3ZkjlYOTHrDGd2A/cSpatUaiA5ufImTiF5jk2+q2ciHbCXQceFSqO2pEI2dx4d1WWMHROQHjmWeP+mIfwIrno7Qczs/6lbVLl+jx2V05Hgt+OiOahQgUzTep9Le7cHDzi+Zk4OVRkRewIboywDdQtswJRBZnJMs+jM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3683.namprd21.prod.outlook.com (2603:10b6:8:b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.10; Wed, 2 Nov
 2022 23:36:45 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::f565:80ed:8070:474b%8]) with mapi id 15.20.5813.004; Wed, 2 Nov 2022
 23:36:45 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Topic: [PATCH v2 4/4] drivers/clocksource/hyper-v: Add TSC page support
 for root partition
Thread-Index: AQHY7web4nCQJ3roNEmkc2vgSsTv0K4sSBLg
Date:   Wed, 2 Nov 2022 23:36:45 +0000
Message-ID: <BYAPR21MB1688672E692E9B618F3B5587D7399@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166742670556.205987.18227942188746093700.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <166742685995.205987.1519185062889413335.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166742685995.205987.1519185062889413335.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6d98f157-ecd7-4c72-8970-fc2af704903e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-11-02T23:30:17Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3683:EE_
x-ms-office365-filtering-correlation-id: 6d1c7d0f-eee3-41f4-2ff8-08dabd2b1aae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tRawYyELYOtGOLYG9HSj4wc/3dkts/3E5KYFlqm5+ST6YAyTM5CYYJhOD64Is70YNChFAv9/DImGlhb2haOA0kD92MdXEfh0u1j3I30FE7K1BBfryXEV6vgcjKf8fgGQ7IsklDhqYeEPGHETK2scV2vce4YmnqsIKRbfBEcrVRXtdwTcuq0PUIfJ9s7bZwLWVTYvAZrzU4BMZwoTLLC2q1gkjBm60RbaMmgQVaXPYe4K0d74PmCLSRWG/a+M0B0l4jJ+6Y5VvOtURim7Rgq3/bPRhIRMGmu3c5z62K5UkF+u24AKuRTzEzY0Bitw4pyEY90OxkHBxQnsx6PwxKhkMUrzTU1PsJYAmy1S7NJs9Y6p5as9HaMWMbEPfjmy780oiXjWCQqvTygBBezPnm6ReAoBN+dAUJMdI1UilRsQ6Gi+Yl0E9XJfURLfH4l+4dBSE8vAYS/befzy2CeS6OQZhbJP8dubcMCChb9MhBZ65TG3iMw9LENJFPS+HeSd2j8s23wZgpiCmYKP3g+rhSLN+ho1EJCIyFgWNl/TxKVEUkxVf+mcLAwh0RyNkEsEtUeEExC+cKQm4dQ5/HMBnMEJftw/rmdq2x9IdLdnBAAN7DBl8sUu32Vpak9y2QYbbrBTLqEKjBRpQcqVK3v8OzJ15BM78E5csi7KG5AeEPK+wS+gFMZ9UPRlEHf/oXmOnQZHpSWnCz4LbLShXkuCmHImpgfz15+BpByz8JW+OgaIpMOOi7TQuG5qQSdwxfs5yRIHvNzpOlUUE3oGyEu++yHr9mzsyCmp57eB/WFgaK4TgHo/PrsVAxdaMH/OsQUMTqam
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(366004)(346002)(396003)(376002)(451199015)(54906003)(316002)(76116006)(10290500003)(7696005)(66899015)(66446008)(4326008)(66476007)(8676002)(6506007)(66946007)(64756008)(41300700001)(71200400001)(26005)(9686003)(478600001)(8936002)(6862004)(66556008)(52536014)(5660300002)(186003)(7416002)(2906002)(83380400001)(38070700005)(38100700002)(8990500004)(122000001)(82960400001)(33656002)(82950400001)(55016003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUFRVnd4SUxYSG5BQWlQRmJrWWVGUWtQN1J3STdObmpkSlNmV2lDenVVZFNS?=
 =?utf-8?B?RUtjaU9FUDdPc0RpOWlla0NOak0xUm53SkdlZHhCRWRncldFT1FqbkpiL2dC?=
 =?utf-8?B?NEZqTEtsYlNtR2JVdEFnNlZkNGd4TURsUEN3S3RrM1I1d09OcGRIVENwSGts?=
 =?utf-8?B?S0JSM1ZETUkwV2JCZmx2MGUzZ0Jqc0REZ3JjTjBPbDQ3MnYvd2xsVmxrR0tt?=
 =?utf-8?B?UXNTSmlIejR0b2RiUXduVVdGcjBpOW5qdUtkRCt2emVUUUJMeW11UHN0S3ZK?=
 =?utf-8?B?dlRnZDVVdHhva3NpQW52aTYyVGlvYU9abDd6dWJ2N2I4QXpyWUdzSWFlMjFi?=
 =?utf-8?B?cXdRYzBpT2FTd3J1NENuOVNqUkxhaDFzRTFtd2dxQStNVFk2eGw2Uk4xWUVD?=
 =?utf-8?B?bEVkYU5KR3Y1SXBnWmxkVEVkN2pKNW83UElGOCtkek1OenRac3V1b3JQM3pT?=
 =?utf-8?B?TUMyV1hiVTZ0Yi9Ieng3V2ROMlVzOEd5RVErZzh6SzNwV3V0dU8rSGdXS09T?=
 =?utf-8?B?VnAvQjRON1ZMa0lUMHJ1QTRpaThOYkU2YmpINXFXQVp1L1JRVHRPanA3VDJP?=
 =?utf-8?B?YlBjNnJhUklFN2l1UXBUOXNlNWZQUDRseDUxRWdGbjNEQ0NTNzVzTjJkRW56?=
 =?utf-8?B?TzYyMGlZMjA1UjcxTmdRMkdIcng1YkdweVlSL3VqT1ZSemZ1eFhWblNLRU1q?=
 =?utf-8?B?WFJFZ05RZkZ0bkV2K3dRNGdSY0RULytibW40K2lQVVhrNGVFYk5EcysyQmx2?=
 =?utf-8?B?dGQzYVZKdUMvQjcvdlRqcFZ0Q3g3bjhRUkJBRDh1enkzWG5hWXhXWGppODg5?=
 =?utf-8?B?N1hsbFVEbncyMngzSUdta1VhZlRNZHYzbk5SekwxRHdWYVk0bjZtWkpDeFl1?=
 =?utf-8?B?V1E2YTdzRHhJV3BxVWc5cDZDWHNXU05sUXJBVXZnZnVOR3VyWkVtQktvNjlk?=
 =?utf-8?B?L2NmZm0wUGpPMTFneWhZR004MW56VktLZFBUUEtrbDNSQS9YVFZCd3U2dEYr?=
 =?utf-8?B?QTlXU3J0TVpKY3FVVysydjdQSURhRW82RmdEdVdPaDZlaXBEcTN5a1ZQcG5I?=
 =?utf-8?B?WkpCOTdqUThUMVZZamp1SHI0UU9mS3BLUFNIamc5a0J3Z2p5dEQ4RkVWSThU?=
 =?utf-8?B?K2s2VUtzdncyWjFETDM5eWFNK2FzUUh6S3lYZmJNQkhJS0dkQ1JFcGViYy9G?=
 =?utf-8?B?OC9KQkduRklqQ1JLZmU0bGNCaThPVS9EaStlakVDdUpkZWYrRjVJVnBOU29E?=
 =?utf-8?B?aTlBWjBCZGdDTXlrUkd4ZExJOVpnbEpiQUgzaFFkaXptc3dneFV5VHNQejla?=
 =?utf-8?B?a3p6emd1Mml2NzRibU5nNGdWYXREUlNObXNNKzJjR2ZQYi9yaFROSVZxNk1y?=
 =?utf-8?B?SUJaaDJUZ29Sa2YwUjZaVUFxMURhdmN2Tmx5KzlocE9ZOWY0N0l5bWs3VURZ?=
 =?utf-8?B?UXFRV1hxUEZjNkhuKys2d01qeENUdFkwOXZsRG5GdTdRZ0JhN3pjc2NMMG0v?=
 =?utf-8?B?dzZXUG1hTWhTZnlEeW9Gb3I2cjBKOFlXT1V0V1FBMWRNbUovVzJlQ3JEMTJk?=
 =?utf-8?B?NUcvNkpyVlgvSi9HVFJINitGTFppa1VUQkYycjI0eW14QnVNaUxWVWlpNnkv?=
 =?utf-8?B?YzFQbTVxRXJiVEduNjIydWpydVA0bUY2UG1kcG1GVzUybG5ZbE1kSytjd2Ni?=
 =?utf-8?B?UFVvbWlDQk1EYzVLNmdMZnB6U0EwNXowZmNXR0JQUklLQUNnaEJnb01YQlpz?=
 =?utf-8?B?WUtqaFVNZXV5M1NtSlpiRkNIbEF1aHhRTFQ1V0t2QjBNWXRwTTFuOTFscnd1?=
 =?utf-8?B?eWcxb3ZjRXdHU2hXbjVBM2VZU3ZHUVFWaEVSWDg0OS9CV2tiRnZYODBZeXNj?=
 =?utf-8?B?ajBrd05vaXp6ZEpleXJaY2VkUU5NbjVXaG45T3NOTjZBKzRYSHZoWW1EYm5E?=
 =?utf-8?B?ZW43UEhIMHl4OW1GdnEyY0xVdDBsb2FCOE5jRTl1ck9TV3JmOTRIUTU0WlNN?=
 =?utf-8?B?SzJ2cWtBL0FibVV4UTlmYkdnZnFCemhWeU5hK1FxSmpQZmJsNUUyUkFmQVBx?=
 =?utf-8?B?Wk56d3owSDBpZ3VMZmRIaUxBbGpLVHVmQ3VQNzdRRFYzOWlBV2kycHBhdXBG?=
 =?utf-8?B?VEg1cUVLM21YT0ZCdmRqdHFkUXpmZEtoRWtqbkJUUUVTbVFWUzRieVFIemI2?=
 =?utf-8?B?bGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1c7d0f-eee3-41f4-2ff8-08dabd2b1aae
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 23:36:45.5056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUTf/xtCSB8xcgdRp6S6PFnlyn5TkHnk19H1T1mMFNwQsNoLIPTQmUckmRwE+64LJiPs3aJX6VCbldQDdodUHfYXbkIg2X4zUR8iTEqknZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyLCAyMDIyIDM6MDggUE0NCj4gDQo+IE1p
Y3Jvc29mdCBIeXBlcnZpc29yIHJvb3QgcGFydGl0aW9uIGhhcyB0byBtYXAgdGhlIFRTQyBwYWdl
IHNwZWNpZmllZA0KPiBieSB0aGUgaHlwZXJ2aXNvciwgaW5zdGVhZCBvZiBwcm92aWRpbmcgdGhl
IHBhZ2UgdG8gdGhlIGh5cGVydmlzb3IgbGlrZQ0KPiBpdCdzIGRvbmUgaW4gdGhlIGd1ZXN0IHBh
cnRpdGlvbnMuDQo+IA0KPiBIb3dldmVyLCBpdCdzIHRvbyBlYXJseSB0byBtYXAgdGhlIHBhZ2Ug
d2hlbiB0aGUgY2xvY2sgaXMgaW5pdGlhbGl6ZWQsIHNvLCB0aGUNCj4gYWN0dWFsIG1hcHBpbmcg
aXMgaGFwcGVuaW5nIGxhdGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNi
dXJza2l5IDxzdGFuaXNsYXYua2luc2J1cnNraXlAZ21haWwuY29tPg0KPiBDQzogIksuIFkuIFNy
aW5pdmFzYW4iIDxreXNAbWljcm9zb2Z0LmNvbT4NCj4gQ0M6IEhhaXlhbmcgWmhhbmcgPGhhaXlh
bmd6QG1pY3Jvc29mdC5jb20+DQo+IENDOiBXZWkgTGl1IDx3ZWkubGl1QGtlcm5lbC5vcmc+DQo+
IENDOiBEZXh1YW4gQ3VpIDxkZWN1aUBtaWNyb3NvZnQuY29tPg0KPiBDQzogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENDOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0
LmNvbT4NCj4gQ0M6IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPg0KPiBDQzogRGF2ZSBI
YW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gQ0M6IHg4NkBrZXJuZWwub3Jn
DQo+IENDOiAiSC4gUGV0ZXIgQW52aW4iIDxocGFAenl0b3IuY29tPg0KPiBDQzogRGFuaWVsIExl
emNhbm8gPGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+DQo+IENDOiBsaW51eC1oeXBlcnZAdmdl
ci5rZXJuZWwub3JnDQo+IENDOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0K
PiAgYXJjaC94ODYvaHlwZXJ2L2h2X2luaXQuYyAgICAgICAgICB8ICAgIDIgKysNCj4gIGRyaXZl
cnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMgfCAgIDM3ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLQ0KPiAgaW5jbHVkZS9jbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIuaCB8
ICAgIDEgKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2h5cGVydi9odl9pbml0LmMgYi9hcmNo
L3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+IGluZGV4IGY0OWJjM2VjNzZlNi4uODk5NTQ0OTBhZjkz
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9oeXBlcnYvaHZfaW5pdC5jDQo+ICsrKyBiL2FyY2gv
eDg2L2h5cGVydi9odl9pbml0LmMNCj4gQEAgLTQ2NCw2ICs0NjQsOCBAQCB2b2lkIF9faW5pdCBo
eXBlcnZfaW5pdCh2b2lkKQ0KPiAgCQlCVUdfT04oIXNyYyk7DQo+ICAJCW1lbWNweV90b19wYWdl
KHBnLCAwLCBzcmMsIEhWX0hZUF9QQUdFX1NJWkUpOw0KPiAgCQltZW11bm1hcChzcmMpOw0KPiAr
DQo+ICsJCWh2X3JlbWFwX3RzY19jbG9ja3NvdXJjZSgpOw0KPiAgCX0gZWxzZSB7DQo+ICAJCWh5
cGVyY2FsbF9tc3IuZ3Vlc3RfcGh5c2ljYWxfYWRkcmVzcyA9DQo+IHZtYWxsb2NfdG9fcGZuKGh2
X2h5cGVyY2FsbF9wZyk7DQo+ICAJCXdybXNybChIVl9YNjRfTVNSX0hZUEVSQ0FMTCwgaHlwZXJj
YWxsX21zci5hc191aW50NjQpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbG9ja3NvdXJjZS9o
eXBlcnZfdGltZXIuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gaW5k
ZXggNjM1YzE0YzFlM2JmLi5lYzc2MzAzYjJhNzYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xv
Y2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmMNCj4gKysrIGIvZHJpdmVycy9jbG9ja3NvdXJjZS9oeXBl
cnZfdGltZXIuYw0KPiBAQCAtNTA4LDkgKzUwOCw2IEBAIHN0YXRpYyBib29sIF9faW5pdCBodl9p
bml0X3RzY19jbG9ja3NvdXJjZSh2b2lkKQ0KPiAgCWlmICghKG1zX2h5cGVydi5mZWF0dXJlcyAm
IEhWX01TUl9SRUZFUkVOQ0VfVFNDX0FWQUlMQUJMRSkpDQo+ICAJCXJldHVybiBmYWxzZTsNCj4g
DQo+IC0JaWYgKGh2X3Jvb3RfcGFydGl0aW9uKQ0KPiAtCQlyZXR1cm4gZmFsc2U7DQo+IC0NCj4g
IAkvKg0KPiAgCSAqIElmIEh5cGVyLVYgb2ZmZXJzIFRTQ19JTlZBUklBTlQsIHRoZW4gdGhlIHZp
cnR1YWxpemVkIFRTQyBjb3JyZWN0bHkNCj4gIAkgKiBoYW5kbGVzIGZyZXF1ZW5jeSBhbmQgb2Zm
c2V0IGNoYW5nZXMgZHVlIHRvIGxpdmUgbWlncmF0aW9uLA0KPiBAQCAtNTI4LDE2ICs1MjUsMjIg
QEAgc3RhdGljIGJvb2wgX19pbml0IGh2X2luaXRfdHNjX2Nsb2Nrc291cmNlKHZvaWQpDQo+ICAJ
fQ0KPiANCj4gIAlodl9yZWFkX3JlZmVyZW5jZV9jb3VudGVyID0gcmVhZF9odl9jbG9ja190c2M7
DQo+IC0JdHNjX3BmbiA9IF9fcGh5c190b19wZm4odmlydF90b19waHlzKHRzY19wYWdlKSk7DQo+
IA0KPiAgCS8qDQo+IC0JICogVGhlIEh5cGVyLVYgVExGUyBzcGVjaWZpZXMgdG8gcHJlc2VydmUg
dGhlIHZhbHVlIG9mIHJlc2VydmVkDQo+IC0JICogYml0cyBpbiByZWdpc3RlcnMuIFNvIHJlYWQg
dGhlIGV4aXN0aW5nIHZhbHVlLCBwcmVzZXJ2ZSB0aGUNCj4gLQkgKiBsb3cgb3JkZXIgMTIgYml0
cywgYW5kIGFkZCBpbiB0aGUgZ3Vlc3QgcGh5c2ljYWwgYWRkcmVzcw0KPiAtCSAqICh3aGljaCBh
bHJlYWR5IGhhcyBhdCBsZWFzdCB0aGUgbG93IDEyIGJpdHMgc2V0IHRvIHplcm8gc2luY2UNCj4g
LQkgKiBpdCBpcyBwYWdlIGFsaWduZWQpLiBBbHNvIHNldCB0aGUgImVuYWJsZSIgYml0LCB3aGlj
aCBpcyBiaXQgMC4NCj4gKwkgKiBUU0MgcGFnZSBtYXBwaW5nIHdvcmtzIGRpZmZlcmVudGx5IGlu
IHJvb3QgYW5kIGd1ZXN0IHBhcnRpdGlvbnMuDQo+ICsJICogLSBJbiBndWVzdCBwYXJ0aXRpb24g
dGhlIGd1ZXN0IFBGTiBoYXMgdG8gYmUgcGFzc2VkIHRvIHRoZQ0KPiArCSAqICAgaHlwZXJ2aXNv
ci4NCj4gKwkgKiAtIEluIHJvb3QgcGFydGl0aW9uIGl0J3Mgb3RoZXIgd2F5IGFyb3VuZDogaXQg
aGFzIHRvIG1hcCB0aGUgUEZODQo+ICsJICogICBwcm92aWRlZCBieSB0aGUgaHlwZXJ2aXNvci4N
Cj4gKwkgKiAgIEJ1dCBpdCBjYW4ndCBiZSBtYXBwZWQgcmlnaHQgaGVyZSBhcyBpdCdzIHRvbyBl
YXJseSBhbmQgTU1VIGlzbid0DQo+ICsJICogICByZWFkeSB5ZXQuIFNvLCB3ZSBvbmx5IHNldCB0
aGUgZW5hYmxlIGJpdCBoZXJlIGFuZCB3aWxsIHJlbWFwIHRoZQ0KPiArCSAqICAgcGFnZSBsYXRl
ciBpbiBodl9yZW1hcF90c2NfY2xvY2tzb3VyY2UoKS4NCj4gIAkgKi8NCj4gIAl0c2NfbXNyLmFz
X3VpbnQ2NCA9IGh2X2dldF9yZWdpc3RlcihIVl9SRUdJU1RFUl9SRUZFUkVOQ0VfVFNDKTsNCj4g
KwlpZiAoaHZfcm9vdF9wYXJ0aXRpb24pDQo+ICsJCXRzY19wZm4gPSB0c2NfbXNyLnBmbjsNCj4g
KwllbHNlDQo+ICsJCXRzY19wZm4gPSBfX3BoeXNfdG9fcGZuKHZpcnRfdG9fcGh5cyh0c2NfcGFn
ZSkpOw0KDQpTYW1lIHByb2JsZW0gaGVyZSB3aXRoIHNldHRpbmcgdHNjX3BmbiB0byBhIGd1ZXN0
IFBGTiwgd2hpY2ggbWF5IGJlDQpEaWZmZXJlbnQgZnJvbSB3aGF0IEh5cGVyLVYgaXMgZXhwZWN0
aW5nIGFzIGEgUEZOIHR3byBsaW5lcyBiZWxvdy4gIEkga25vdw0KdGhlIGFib3ZlIGxpbmUgd2Fz
IGp1c3QgY2FycmllZCBvdmVyIGZyb20gQW5pcnVkaCdzIHByZXZpb3VzIHBhdGNoIHNldCwNCmJ1
dCBJIHdhcyB0aGlua2luZyB5b3Ugd291bGQgZml4IHRoaXMgaXNzdWUuIDotKQ0KDQo+ICAJdHNj
X21zci5lbmFibGUgPSAxOw0KPiAgCXRzY19tc3IucGZuID0gdHNjX3BmbjsNCj4gIAlodl9zZXRf
cmVnaXN0ZXIoSFZfUkVHSVNURVJfUkVGRVJFTkNFX1RTQywgdHNjX21zci5hc191aW50NjQpOw0K
PiBAQCAtNTcyLDMgKzU3NSwxOSBAQCB2b2lkIF9faW5pdCBodl9pbml0X2Nsb2Nrc291cmNlKHZv
aWQpDQo+ICAJaHZfc2NoZWRfY2xvY2tfb2Zmc2V0ID0gaHZfcmVhZF9yZWZlcmVuY2VfY291bnRl
cigpOw0KPiAgCWh2X3NldHVwX3NjaGVkX2Nsb2NrKHJlYWRfaHZfc2NoZWRfY2xvY2tfbXNyKTsN
Cj4gIH0NCj4gKw0KPiArdm9pZCBfX2luaXQgaHZfcmVtYXBfdHNjX2Nsb2Nrc291cmNlKHZvaWQp
DQo+ICt7DQo+ICsJaWYgKCEobXNfaHlwZXJ2LmZlYXR1cmVzICYgSFZfTVNSX1JFRkVSRU5DRV9U
U0NfQVZBSUxBQkxFKSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJaWYgKCFodl9yb290X3BhcnRp
dGlvbikgew0KPiArCQlXQVJOKDEsICIlczogYXR0ZW1wdCB0byByZW1hcCBUU0MgcGFnZSBpbiBn
dWVzdCBwYXJ0aXRpb25cbiIsDQo+ICsJCSAgICAgX19mdW5jX18pOw0KPiArCQlyZXR1cm47DQo+
ICsJfQ0KPiArDQo+ICsJdHNjX3BhZ2UgPSBtZW1yZW1hcChfX3Bmbl90b19waHlzKHRzY19wZm4p
LCBzaXplb2YodHNjX3BnKSwgTUVNUkVNQVBfV0IpOw0KDQpOb3RlIHRoYXQgdXNlIG9mIF9fcGZu
X3RvX3BoeXMoKSBpcyBhdCByaXNrIG9mIGJlaW5nIHdyb25nIGRlcGVuZGluZyBvbiB3aGV0aGVy
DQp5b3UgZGVjaWRlIHRvIGtlZXAgYSBndWVzdCBQRk4gb3IgYSBIeXBlci1WIFBGTiBpbiB0c2Nf
cGZuLg0KDQo+ICsJaWYgKCF0c2NfcGFnZSkNCj4gKwkJcHJfZXJyKCJGYWlsZWQgdG8gcmVtYXAg
SHlwZXItViBUU0MgcGFnZS5cbiIpOw0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9jbG9j
a3NvdXJjZS9oeXBlcnZfdGltZXIuaA0KPiBiL2luY2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3Rp
bWVyLmgNCj4gaW5kZXggMzA3OGQyM2ZhYWVhLi43ODM3MDFhMjEwMmQgMTAwNjQ0DQo+IC0tLSBh
L2luY2x1ZGUvY2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVyLmgNCj4gKysrIGIvaW5jbHVkZS9jbG9j
a3NvdXJjZS9oeXBlcnZfdGltZXIuaA0KPiBAQCAtMzEsNiArMzEsNyBAQCBleHRlcm4gdm9pZCBo
dl9zdGltZXJfZ2xvYmFsX2NsZWFudXAodm9pZCk7DQo+ICBleHRlcm4gdm9pZCBodl9zdGltZXIw
X2lzcih2b2lkKTsNCj4gDQo+ICBleHRlcm4gdm9pZCBodl9pbml0X2Nsb2Nrc291cmNlKHZvaWQp
Ow0KPiArZXh0ZXJuIHZvaWQgaHZfcmVtYXBfdHNjX2Nsb2Nrc291cmNlKHZvaWQpOw0KPiANCj4g
IGV4dGVybiB1bnNpZ25lZCBsb25nIGh2X2dldF90c2NfcGZuKHZvaWQpOw0KPiAgZXh0ZXJuIHN0
cnVjdCBtc19oeXBlcnZfdHNjX3BhZ2UgKmh2X2dldF90c2NfcGFnZSh2b2lkKTsNCj4gDQoNCg==
