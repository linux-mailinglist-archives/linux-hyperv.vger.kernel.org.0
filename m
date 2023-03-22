Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0AE6C5532
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Mar 2023 20:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCVTwb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 22 Mar 2023 15:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVTw1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 22 Mar 2023 15:52:27 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8197350991;
        Wed, 22 Mar 2023 12:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZNYNjxTORtpvAHpaabCaElARjoN+Q/fakk6FotxKqLbDP/leVBdwr6nFH3gCHFTElD0tGXn5xG96s2ew0yCX+zypOOCx7XzfIAWOtOTU37UqdgbFlENpZlpU6PJJbhAn/w19i++IknTxyze/YlZ036psw8qvxYwdIkSTV+tsr0sX1vjNkE4cYsy+3ruLPa6SO9p/Gmm5mvquJzoHLQnx+dRnqOm+n1wIkwMjVLARy2l86gTpaSJ/MoNC4ihlvnvDO3l4EtdUsbDzojSvEzDOwhck2QZxaKuzxdOKMe8jOsEOLiTxCmj/4WjJk07LBx7iR8OhrkSJQVofn9CEVTI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejsyPVeF0R5IClTRiQ9oYd9AIP/ILdvT7SV33LtSafA=;
 b=YZPOij2EjHSxv1IEDJLbSytMCyQVB31CIgz7LRt7kGImtI5GvgOSz3aTOEAJVuPzr4zXAxGMDmpJassmT8+kKPTtN7i5vTjStauwwXv6MsM4tjZ8zaCIu9DTtn+3baN2c9lZaBQ12kGdqaUfGzR7BPUDqSvuv+oXQOCgVjuEKB7dmCz5SDl0r22PBXv9IVbpagls6C10t4X1F+nDx2+Hu5bFBCNg67Eh1n1f3us38A03PNsH82p6/JlWXM6d4VCYTfhI5oSRhKetSy6U9YBpmjMJAhnWhvyOd/KD0tlnGe8Nbj4aIVV84rTZHpgmN7aYaVVtLwwws9TX6DLRFallig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejsyPVeF0R5IClTRiQ9oYd9AIP/ILdvT7SV33LtSafA=;
 b=RtBoLgSCE80WNjRBST8RlFcOpa/Tu8TOnUYVzYPGV/+D8yJ30qvKKOr+hTAkp05Iw/a3gLyfrzXqle11IvS8VPTyhTr+x/CgmFc3kIWfsDwQKrJ9Tq1Pec+S/8gBYB+qCWJk6MXsrcpqYF2AY59//wZY3fn3PIstaCZzcVMjKnY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3750.namprd21.prod.outlook.com (2603:10b6:208:3d0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.0; Wed, 22 Mar
 2023 19:52:22 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::acd0:6aec:7be2:719c%7]) with mapi id 15.20.6254.004; Wed, 22 Mar 2023
 19:52:21 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Thread-Topic: [PATCH 1/1] x86/irq: Add hardcoded hypervisor interrupts to
 /proc/stat
Thread-Index: AQHZStvOKEpex/oSu0efNAklHfBImK8HPJyAgAAZNIA=
Date:   Wed, 22 Mar 2023 19:52:21 +0000
Message-ID: <BYAPR21MB16884B3D0E15E501A7BB8E78D7869@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
 <dce372bd-e63c-f24c-5b79-1ef65fd1e59a@intel.com>
In-Reply-To: <dce372bd-e63c-f24c-5b79-1ef65fd1e59a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=408eea84-a6b3-409b-82bb-102b768a31b3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-22T19:37:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3750:EE_
x-ms-office365-filtering-correlation-id: 20352a39-351a-46bf-137f-08db2b0ef390
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sgMeLJ673A7wms8TvelBaZ281qfcL1zH/4qGlEO8Fwq9sUj2ie19WDCnUlK9+tCe/HozAYO/xFWidSKqumBmFerGqC+xFAoV3nKwoIcZ3HDvYdT6HX1MPLpv6qucBxcRw9x7JtYINiBh5fuBpO/PY9ufpZYrKzb8tni4/tIN2iHzMR80v8sywRb2qId63ioWe4DLM6+a/3pKeqmaaDAyUOnG80FLC+Qgn+8qJFTHg9CPkWydtShGpBz5WhOwQmjdkYp42+nAah561uxQ4wVcGGuIMvFV8oGigtRUN9qoWfvVuKh6ZdkObpkWJ+81apKaHlDNxzIRkYI1rQbtuPACrCmHAdS4LtLCKGEBlvDknzgChNMnxVKwrM5DIFFqOK/Kj9EpIBQvIZYQVABe201tRgKfJ0ie005r7/Nj8YJAbx3dYK+MAFUi/DDYjz+s3Vt3Cx3tURuupwz3DFo1cfjajqo2UPMnEOBDnVSyJfDgxKMig0tIeVPi9xRqf4lvLBgKV4LFDpe8gfgWumpzfQx9FMmZ4WLjI8GrobU+TNgjk8tjGLFZ34N7IIFXtj/1j75iqglPu2t3ZBpNCszj4h5ve5tTaGm4UmupnWiZwGODtpP96nABZDFFlkPPD2ecXy3roLCMwPio7DfITbsr5LVQtQH20TICf8MfPidWJEjlqIo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(451199018)(38100700002)(122000001)(2906002)(33656002)(7696005)(38070700005)(86362001)(82950400001)(52536014)(478600001)(82960400001)(41300700001)(8990500004)(5660300002)(8936002)(6506007)(316002)(55016003)(10290500003)(9686003)(53546011)(110136005)(186003)(26005)(76116006)(66476007)(66946007)(71200400001)(66556008)(66446008)(8676002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UmhCNEtkdzJyVmV0bnQ4WU5KNzZFWTVQSlRmbENMWkErUWQvWXBEYzBuakpT?=
 =?utf-8?B?Y0tFK1ZvN3JiTDdPdGswTkVqaVYwZGxsWkorTUpyeXNaTkpvZHZHZ0JUMXFB?=
 =?utf-8?B?RGJYekhPWERsTEJxWDJQdjRxTGxiTFNVdEd2cXFnVDM3QS9XMk1uTDFURzVm?=
 =?utf-8?B?LzRrNm9sQVRKaGxKUGs0VjlON21vbnJrV1VFaGVSbWIwUDQ4WlQzRFVPbFVw?=
 =?utf-8?B?dnRCN1E1TU1NN3BrUGtGeFhSQ3o3RTU0Qjk4S2dXUnI4T0xOMUdBOXo3aC93?=
 =?utf-8?B?TyttQUM5OG9IMnFqNHNBN1ZrcnowdVBVeXVCa3phenVHb1FQSGp3QWVRak5z?=
 =?utf-8?B?M2NiSklRdHVhWnNXZ1ZWQ3krRGJ4NHovT3k0S1Z6WHV5b1BLNVVZRXVqSnJD?=
 =?utf-8?B?WVNmSS83UUhZTzJOb0RaaWRHdFZ6eGlmS1FBc0xxY0tydDhNci9XckV4Rzhz?=
 =?utf-8?B?cmUxWG9iRHRxVWlxbVQySFZaMS9BTmZKaVpxU3Y3VDdybkJ5ZUJVaFphYWRZ?=
 =?utf-8?B?Q3BLZXpPTTJGT3J5MXRJc25kMWppeWVldjZUdG84QkZGamppb0g0WDdUMzFy?=
 =?utf-8?B?TXoxcjNxSHJuWExkV09iYW9TeTk5MUlZRFVKQXV1UjF1Q1BiTWVjaElucFBs?=
 =?utf-8?B?akVHU2RVRUM4Ykg1TFpWVHhFSmhhNWRyRlk0L0lqVTFucWpwSmk1SjU2ZWEy?=
 =?utf-8?B?bTVCWWZ5YzRpVXYrOFRZVEVVbTUrRE1xdE5PTkEwajJ1UE1hRFNvWmNJVzZU?=
 =?utf-8?B?dzZtK2RXL0FmSnVOV3pYZ1gzeWkvWU9DdEw0RDFBcWVoNlZmclBzRWZpa0s0?=
 =?utf-8?B?MDQ4S2YrMUZpYno2cEpsSDJWNXYvanhydDZjQk1mcUpZV2c2ZmpqQWpQMk84?=
 =?utf-8?B?QnN1MmRRNUFMenJCbkJDVkhFbUNra1RwN3dkVkJleWw4OEVVbnEreTRvQ05E?=
 =?utf-8?B?dEJGQlRSaFdsbjhjb2FlVUMwWXNVQ0RUL1dTL2dqVVZEZjUveFBYeDJqMERB?=
 =?utf-8?B?ZmJVejNKWUFDbjVZbldoczJ3WW1SMkJNNytaOGY5UldTTEJua2lseFpKTURL?=
 =?utf-8?B?KzhmRXExMEdBaHZmSXZxM091Qms0d1lSdUdQVEZzR0NmMjRwdkRYaU52ZTNP?=
 =?utf-8?B?QUVHUHJqZlFIL0E4ZmJvUU0yZnJWR1hkYU02dCs3a2o0VHp1TCthSWVLWVFI?=
 =?utf-8?B?MXZwaTdPQjQrZlp1M1hGcW9Nd01SNC91aXFORUJFekRPZnkxcnkzTW1Qakhh?=
 =?utf-8?B?Yk9PVlMrSFZ4d2E5eENmMU9DMVNvT3pFMGZoNURUNWQ0UEJyVWZoOGFzMjRT?=
 =?utf-8?B?U0JkZzRYYUNTQ1R6Y0pwd2pGUGdJUngvZ2VWMWdTcjlNR2xaSGc5WXRFUENt?=
 =?utf-8?B?d1RXOUdTdTBPQnovMFdRWG9TeUhIbTRzeFpTeEVvTTlyT1hwcyt1UUE3dEta?=
 =?utf-8?B?eDJzK0pXRlk4bUgxKzdlUERheWNjaGhRNFhVSTZUY3Q0Q0JsZ2RzR1NqTGlJ?=
 =?utf-8?B?bXpJaGg0bVNYL3ZacFkrVFlpWi9odkJnQWZLdGJGUDZnOFUyUTZIMmt5T1A4?=
 =?utf-8?B?OWRyc01KR2pmcFMyVTRSMXdwWHd0Znc1Zi9qRURtUUZ4VGw3VVllS1RFekhQ?=
 =?utf-8?B?dE81ODdEbFkrVnA4bzc1R2xzV1dmcGVZUVdhM3NuazhyYlhiRVhsUWlJUFF0?=
 =?utf-8?B?NXNNY3gzZnFSZnRuWmJmY29RVXpWbzdiaU9PZnJJdEdmZ2RVbjFMcWd0WHpo?=
 =?utf-8?B?bGpucmRydEdFVW12WkdFZHBQSG0zaU1NSGZPSVZDNlV0cnJWZGpEU3crMmxN?=
 =?utf-8?B?RkJFblhQckZrN3JXZldtUEJib2NuMStqLzh2VUVMZG1iZHdCakl6ZDk1VnAx?=
 =?utf-8?B?WFhWMUtWaXZaa3FRbEZpeXZ1cUFIelVzKzZob0Z5R1VkbDVkUVNzYUFETWFi?=
 =?utf-8?B?Ump5amtWWjN6VE1ibmlWNHhqeWMyenRxeEllLzI3MEFnWVE3WlRoLzh6WjVw?=
 =?utf-8?B?WjhTNGRmWHJBbUZ5am5EcUJ1SDVibHB5bDdjTDJKTUNCSWFUMGVETTcvTnNr?=
 =?utf-8?B?cnNqNUk3bE16aEM2NmxQdmppWE5NakdFbzFEOHVrc2xCNStTQVY1dmwrN3FI?=
 =?utf-8?B?RFFSVWZiMUxXNHU1Z3R2V1ZjcjhNR3NRc3A2N0wxM3Z3LzlVejl5OGx1V1J3?=
 =?utf-8?B?NVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20352a39-351a-46bf-137f-08db2b0ef390
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 19:52:21.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmbh/1WL+lV4scf2eKxYWj49HoctbflE6ntU/7IPueeLtqo4TEqdl18M2Pw4ETOOkMP75tprO+56m+Cn9ymcPb/5M3HuEV50rh8TrUR9+gk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3750
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGludGVsLmNvbT4gU2VudDogV2VkbmVzZGF5
LCBNYXJjaCAyMiwgMjAyMyAxMTowNyBBTQ0KPiANCj4gT24gMi8yNy8yMyAxMDo0NiwgTWljaGFl
bCBLZWxsZXkgd3JvdGU6DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9pcnEuYyBi
L2FyY2gveDg2L2tlcm5lbC9pcnEuYw0KPiA+IGluZGV4IDc2NmZmZTMuLjlmNjY4ZDIgMTAwNjQ0
DQo+ID4gLS0tIGEvYXJjaC94ODYva2VybmVsL2lycS5jDQo+ID4gKysrIGIvYXJjaC94ODYva2Vy
bmVsL2lycS5jDQo+ID4gQEAgLTIxMSw2ICsyMTEsMTMgQEAgdTY0IGFyY2hfaXJxX3N0YXRfY3B1
KHVuc2lnbmVkIGludCBjcHUpDQo+ID4gICNpZmRlZiBDT05GSUdfWDg2X01DRV9USFJFU0hPTEQN
Cj4gPiAgCXN1bSArPSBpcnFfc3RhdHMoY3B1KS0+aXJxX3RocmVzaG9sZF9jb3VudDsNCj4gPiAg
I2VuZGlmDQo+ID4gKyNpZmRlZiBDT05GSUdfWDg2X0hWX0NBTExCQUNLX1ZFQ1RPUg0KPiA+ICsJ
c3VtICs9IGlycV9zdGF0cyhjcHUpLT5pcnFfaHZfY2FsbGJhY2tfY291bnQ7DQo+ID4gKyNlbmRp
Zg0KPiA+ICsjaWYgSVNfRU5BQkxFRChDT05GSUdfSFlQRVJWKQ0KPiA+ICsJc3VtICs9IGlycV9z
dGF0cyhjcHUpLT5pcnFfaHZfcmVlbmxpZ2h0ZW5tZW50X2NvdW50Ow0KPiA+ICsJc3VtICs9IGly
cV9zdGF0cyhjcHUpLT5oeXBlcnZfc3RpbWVyMF9jb3VudDsNCj4gPiArI2VuZGlmDQo+ID4gICNp
ZmRlZiBDT05GSUdfWDg2X01DRQ0KPiA+ICAJc3VtICs9IHBlcl9jcHUobWNlX2V4Y2VwdGlvbl9j
b3VudCwgY3B1KTsNCj4gPiAgCXN1bSArPSBwZXJfY3B1KG1jZV9wb2xsX2NvdW50LCBjcHUpOw0K
PiANCj4gVGhpcyBzZWVtcyBmaW5lLCBlc3BlY2lhbGx5IHNpbmNlIGFyY2hfc2hvd19pbnRlcnJ1
cHRzKCkgaGFzIHRoZW0uICBCdXQsDQo+IHdoYXQncyB3aXRoIHRoZSAiI2lmIElTX0VOQUJMRUQi
IHZlcnN1cyB0aGUgcGxhaW4gI2lmZGVmPyAgSXMgdGhlcmUgc29tZQ0KPiBkaWZmZXJlbmNlIEkn
bSBtaXNzaW5nPyAgV2h5IG5vdCBqdXN0IGJlIGNvbnNpc3RlbnQgd2l0aCB0aGUgb3RoZXIgY29k
ZQ0KPiBhbmQgdXNlIGEgcGxhaW4gI2lmZGVmIGZvciBib3RoPw0KDQpJJ20gZm9sbG93aW5nIHRo
ZSBjb2RpbmcgcGF0dGVybiBpbiBhcmNoX3Nob3dfaW50ZXJydXB0cygpLCBpbiBpcnFfY3B1c3Rh
dF90LA0KYW5kIG1vc3Qgb3RoZXIgcGxhY2VzIHRoYXQgdGVzdCBDT05GSUdfSFlQRVJWLiAgIE1h
eWJlIGFsbCB0aG9zZSBleGlzdGluZw0KY2FzZXMgYXJlIGEgbWlzLWFwcGxpY2F0aW9uIG9mIERv
Y3VtZW50YXRpb24vcHJvY2Vzcy9jb2Rpbmctc3R5bGUucnN0DQpTZWN0aW9uIDIxLCB3aGljaCBw
cmVmZXJzICJpZiAoSVNfRU5BQkxFRChDT05GSUdfSFlQRVJWKSkiIG92ZXINCiIjaWZkZWYgQ09O
RklHX0hZUEVSViIuICAiI2lmIElTX0VOQUJMRUQoKSIgaXMgbm90IHRoZSBzYW1lIGFzDQoiaWYg
KElTX0VOQUJMRUQoKSkiLiAgOi0pDQoNCiBOZXQsIEkgZG9uJ3QgaGF2ZSBhIHN0cm9uZyBwcmVm
ZXJlbmNlIGVpdGhlciB3YXkuICANCg0KTWljaGFlbA0KDQoNCg0K
