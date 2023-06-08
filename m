Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E737F72839E
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Jun 2023 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbjFHPUx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Jun 2023 11:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbjFHPUv (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Jun 2023 11:20:51 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021024.outbound.protection.outlook.com [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9802D61;
        Thu,  8 Jun 2023 08:20:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdrfM+FmPUebNovZZYWsO+mh/eyhnRwHpSshij6cvN52pvWP0nJrzGXMC8Z1ppRld/2FxomG+kXLeccBTaWKDlXnOm8+AW3gN5yV1UoLK1d1+9gaF7vZkMeJT0rcqdC6BKKpFzS9HX+ieFf0WUfsXgR4z7b7p0GzSO5HPHZWqdnibMZ9hjZgygBu0qagtHCEw39QD5IfdBtUtp509Bbky/72S+aUptdJzX77rhLcBh/bCkDHIpzjuD3Gc750Iyp99I7bsYiOzv0KjLKMWO888SD4hLSXb+IrA6TnEy3nF9NObTcx2nsfr9l1Wft4/Y141rqfnTYGuc/YE6Gviqm1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apQakb7opuLnG3Qw16fgxdPqc4zIfJ2eVYT40iuACq8=;
 b=eNK6ma2QzxokZhBbXpAOIBC2ltBM0BRqb6/IArQC3jGP/RUlHNi0g43YJxzDIznUp+o9kcGsGCYlEdiGJwRWhJgNPIJgLRSq6a3ONHtdBrFsYQXPc2OmINtssD+S7mYvLgXWQH12b1YgRf0nkt8BkcC4jadJYHUhMPQPIXJrIQCG6neeRyFrSVArY51Zj0AY+pxvD7qy3cgexacR4XdTXE3stoPxIZHqOdPaMY8xz7+l/imAIiyTR1/IfIwS80zbEL6s1M6xJcAJfJg39hFDVJn4l8qJmwOooHc1ugMucVjvlBKUmync5MaHrhcFomzSqywVoJ94JbFjrIrhfP8DJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apQakb7opuLnG3Qw16fgxdPqc4zIfJ2eVYT40iuACq8=;
 b=jiRs4OCpL7ax/OcItUPxzYVhvDIxXR8Obhuz3H2YjAc18XXtl0k083WBlv4eUrva/55PehmZY+7Ay/7xu0X/cYJJN+foyQGWjW83xSu4cx7fVpNTlu1kt1ynCtIH8f7sdSTHKASbNRs4CML37g717ijjsAFY9n4+7E/I0eh9DE0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DS0PR21MB3949.namprd21.prod.outlook.com (2603:10b6:8:115::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.14; Thu, 8 Jun
 2023 15:20:46 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6500.004; Thu, 8 Jun 2023
 15:20:46 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
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
Thread-Index: AQHZStvOKEpex/oSu0efNAklHfBImK8HPJyAgHpmqwA=
Date:   Thu, 8 Jun 2023 15:20:46 +0000
Message-ID: <BYAPR21MB1688C273172834D7107F6F22D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1677523568-50263-1-git-send-email-mikelley@microsoft.com>
 <dce372bd-e63c-f24c-5b79-1ef65fd1e59a@intel.com>
In-Reply-To: <dce372bd-e63c-f24c-5b79-1ef65fd1e59a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=82d7c1ce-fb85-4faa-835f-c6363bd6e2b5;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T15:18:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DS0PR21MB3949:EE_
x-ms-office365-filtering-correlation-id: 5f815c0d-6fc1-4611-f77c-08db6833eec6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k6R1pG11tObgeNnf1izCSqsSIfiSSFRzpn630tYu0dNpsUXS4YagUjbNmw8zz5okVNvY28+f/6vt7uVrpE4mTA9oDVrsTY2cOCMOtbPgslMf1iRZa1AaKuxyI7Sy6LIrVH+d0lk7HiodXm2CWD4pSdL0IqBn3pypZlmLKTTNScBFcHUDgB9pGjThwLUu/PeI9NZn2vKJYyqSYqf1lq40wbeGcXzvaUkVf4e34aPQCGyQr3zhTOI6NdK1/VSmfKUc4bu+1xv9TGXSNL7pUzX7yvlIxZTyh/5mmrx02czgnHsH+uCJixjOGf1folfxKOkbyHepBEcV9wbBhmllCvvQ+clu+FHE/b37ajOpscvccRyDMKCvXItU0C4nsp/jzAJSg8ljbB32m/nvvrxlhmxSow/nzR3Zc7bM0v74Twjx4KKzb3MLLGv7Yvao4/k235zOgh11jDUmS0LfvfDhjVDMGagIVK4x4vRqAlw6829M+NU+VQTaCm5975Y8ln+9oA6GoFoQS06Zx3V1ostww4ctnHXtL73Zqiuzd/ArZVdcZdpBmC8IyONCS6Z4EWSRVBLBWAzd91QoqQYz/mzI318mfCf+mFc7NH8sStUu9crtch3HSAF+9e+OJrHLSJWY0+SqrjQJRTWpAvalGVBUuB9jZ3nH8lpKfOeH/NMn6VB7DR0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(66946007)(66556008)(66446008)(66476007)(64756008)(76116006)(478600001)(54906003)(10290500003)(8676002)(52536014)(8936002)(5660300002)(71200400001)(6916009)(4326008)(316002)(41300700001)(7696005)(38100700002)(82950400001)(82960400001)(122000001)(55016003)(9686003)(53546011)(38070700005)(26005)(186003)(6506007)(8990500004)(86362001)(33656002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SWRlcWg3V2tKa3NDS25Vd2lYZG1JcG9NK3FyVzBtb3BWOTI3L3NLR1hkSE00?=
 =?utf-8?B?WXhLUmxLWXVaaHBTVmlyYWZrK2JPd2toTFFHcUJHMzgyblFQWEJBSUlVSWtU?=
 =?utf-8?B?QWRTQnZ1ckxoOUFWSGVwSWJISzA2dHU0VmNFcmZiblNUU2NUUUFKZTBkSTZG?=
 =?utf-8?B?VmNzY0F3S1ViOVhTQVNsUFYvdnpiSk9OcUppUnpXUzA3S09ubEVRakJhanNL?=
 =?utf-8?B?ZWtSZVg4Rk9rMHprcEc4YUxtQlhkUi9xT3V2ZzM0YVpmbzdkdDFha3RLYmlK?=
 =?utf-8?B?MjJJWFZhKytoOExKcE1odjZpSVF4aTBYYUlUZXB3NkRUNmdDRy9BWU1tSHY0?=
 =?utf-8?B?YmZicHBCWFJqb2FvaE1ucDAvWC9Ld2hYVjdUa3pnckRtT0FBUXU5NGdkRnNJ?=
 =?utf-8?B?ZmwzcUNTMzFocHI3L3N4cVYyVW1EMklLaEpVbWEyTThkb2FRUDJBWERRbGx0?=
 =?utf-8?B?RzBKMkhpU0ZmRzlBMFVLdVJ0YUtMZ3NBa3VxRi9DL2FzVitaMWE2SThCVzFC?=
 =?utf-8?B?cGFHckdaUW1yRUc4QXl3UTBLUVBvQ1BxVlp1NUhnenh6Znl0eW1idklXUTBv?=
 =?utf-8?B?Y1FOeWRQRktCMitxZ01iTWlvZW84a3NYS3dqTk9jNTN0TWFiSjB0VTdKUnE4?=
 =?utf-8?B?d3RRZS82VWdlQ2c4K011RG5WZ29IWjh5ZXMwNGt2ektkaFhjM3VmbUpqYkVS?=
 =?utf-8?B?Q1FYK2tCU3BENnkwQ3lEQUFTU28zemY0T09iekdnMWVtdVhvT2lnU3FnNGY3?=
 =?utf-8?B?TXV5VnEva1NOYXZ4Vk9aQ0ZoUzFYMFpsZTREd2hQbnozcis1bEY1dXdRQ3Fu?=
 =?utf-8?B?M0pFenhCT1VHVlFvdnlYRGRvTFVVeGF6cFVjeFEzbEJBeWdXajA5TmRLQUdr?=
 =?utf-8?B?aHFpUWxVTFBhWFRsOWtvSVZVSEtQUlBBZGxaeHJyQjM0UGszUTBBZis0RFFz?=
 =?utf-8?B?QU9uM2F6WUVLbjlzNzRsdmJDVnJzQUkyRVpnVWNsWmNmbW9sd0JwYkVleGd6?=
 =?utf-8?B?VjVLQ3MwY3VRTG41blFoYm13MkwvYlRMbVdGNnZ1THREOGNwaXk4SnRtcUda?=
 =?utf-8?B?bDUvSjF6WjBzVDM0YTY2SzVpbU1LUDNRclFBNFgydnZkRHhXNFIwSkdZMHdj?=
 =?utf-8?B?WkxYa0lmbWNwd2I1S2F4ZTZJdjNQRGhpeURqSDgvNEozK2JtcWJYd3U2dVdB?=
 =?utf-8?B?YWtEcWVmNHc0MWhlQkl2WkQrb0IrN2hrUENjS2ZjcFJkTnd4VUtmeTdYY3li?=
 =?utf-8?B?WVIwUlVBM1VBMTMrajE2LzhNbnkrOEZkU0JwZG00NFlpclkvUzh5bnU2cFpv?=
 =?utf-8?B?ZzhzZ2lWYkpLbVBvL0NhYnRJNE1CeTB4T0pTRmozekoxWU8ydDROcXgzeWp4?=
 =?utf-8?B?ekRIb1hRbW5qQkNQTEMzNHpSUjVqRVdzRWpERGxaeW56cU1hT3VzekFQKzhD?=
 =?utf-8?B?ZzNPdUFlTEEybGZldThUQ2FlT3l4bW0wOHRNSFJSVE9sNmMwUmV5ZmRJSW9z?=
 =?utf-8?B?MEJVVXUzNncxS1Nwd21QU1BoOHJKb0Vwb3k5amFkTmd4d1dGMEo0QUMwN3Zv?=
 =?utf-8?B?UkRTYjhiMEsyc1psbCtPblJmODhnOTJWQzhEbjd0Y3BCS1ljN29sWTRDamVE?=
 =?utf-8?B?UVVoTUhkbVFLYWR6WHJ0N3RpMTU0K29ONFcyMzI0d2FLY1pjSDF1TDkvSThB?=
 =?utf-8?B?dUp3bGptQU16ZGxBUmRweGdSejNUSG9qdU9xOHVVYStseUVYMWlmV1VSQnp3?=
 =?utf-8?B?MklEV1pORkpiVWltVWxTNWIzL0d2NFNvVldWR01VR0dGc1RtOWEwTFdDWGJR?=
 =?utf-8?B?MGpmZlBvZGtQNi9GT05ubXhDM1Z1UHNTTXcvdlM3TFlsdEVkY0JGVDJ5OG9m?=
 =?utf-8?B?TWVEOHo4bGJLNkRyQ2RnL0NxNGl1dmlVZS9VbU1wZ21JLzZuc3JzR3B0N1BG?=
 =?utf-8?B?dlFDWjEwRFB3QUZscTJmZE9GZkF4UW9aempvcGRxZVVJMXUzNlAxbEZqM0R3?=
 =?utf-8?B?cHc4Q3dxemdHa3kvNEZ4RUN5TVN2SzVEcWd1U0Yyc1FOSnd6UUlKWGZSdHd1?=
 =?utf-8?B?NGk5cVIyNTlwVytFTDZ0Z2JHMlpQdml4bERWZTFFS2xNajRvUGhsaE5nNjZC?=
 =?utf-8?B?Y3pySFRQbDhra0dhNDIyQWdlUXNmT0ZRMkJucjhzaGx0TXJsV3gyd3JjYmV3?=
 =?utf-8?B?aGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f815c0d-6fc1-4611-f77c-08db6833eec6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 15:20:46.1487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2lMxs2BpiC0lsIodvI7W8iSQZx4mDCPZ3IOIBxpardWpa8gm2pUCXK0BNRGZlTP83xlGKZTpOkT9tjJH4esMK9jaesYnTAzWQxdMtFUhZhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR21MB3949
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
ZQ0KPiBhbmQgdXNlIGEgcGxhaW4gI2lmZGVmIGZvciBib3RoPw0KDQpEYXZlIC0tDQoNCldpdGgg
U2VhbidzIGV4cGxhbmF0aW9uIGZvciAjaWYgSVNfRU5BQkxFRCwgYXJlIHlvdSBPSyB3aXRoIGdp
dmluZyB0aGlzDQphbiBBQ0sgYXMgYW4geDg2IG1haW50YWluZXI/ICAgVGhpcyBwYXRjaCBoYXMg
YmVlbiBoYW5naW5nIGFyb3VuZCBmb3IgYQ0Kd2hpbGUgbm93IC4uLg0KDQpNaWNoYWVsDQo=
