Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E5669B2C5
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Feb 2023 19:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjBQS76 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Feb 2023 13:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjBQS75 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Feb 2023 13:59:57 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20703.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::703])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDC27D5F;
        Fri, 17 Feb 2023 10:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbC+jYvwnBIvMaZHl8gUO+75SMUZZN8olOsuThxYl4XFe3ecBBcGrnsDgBIWeVE2U793Nzgy+GZreJgz0QEDeXX+Iz24ojP48JF5hjApa/+ODtLqfBYj5yGoq9ILSQbqL4UoA97We48eneCAO27kpu3YVxs9UwCqIQLzfr6jyVdX0m7f526/gS407tYo/E83X2nvyWR+o+oseHOH5Dxoa3IRaM1kDBaxRacCGARcwhu4Vg6juUd9uoDE1xfyJDlpGccVRySh688bE2wIIMpmQehW5sYdTbyopXDoShLH2Oy5/3AxXyS1PiyfO69I1M7zFqydF4Wb0j4n3vOXPpAUGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOmzCAoXw1YDcqj2bsNJsP6Lz1IDbYyFeFkQTXrpRrs=;
 b=Dw1qixOqReZ5R4bUQlnmtTkV2OOTE6eirEnAoIbjbJdAg8lLFdzRhOmrAkNESz/vzkxbsbZj/1h5EP4s2DUHAhlhAiNo+wnwlTxb49jBLdty7hPV46o+OSBu0obKitJOoXELFpgQcb6EvwVKsPWhMOn0c03/UiwTel9a7GAKqKW9ZYw8n56w8SSD/YYt0b+qEmym8RtnN8m8icwzpRfkIsxmxSC80PzSIwLg+ehYybtoWEL1otstWXDVZCU9I4LZ+1x7T4vAGGxyT4+jUJdi+RbXOQG1tn3+jYW0IYfZzzEHOFDC833T/A0+q7UE3LXaexKd65WnzAmMe83WFT5+1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOmzCAoXw1YDcqj2bsNJsP6Lz1IDbYyFeFkQTXrpRrs=;
 b=FHQNSbHHsLI7yX4Tpd7CwOLqWe5zdeRKVfrfQxM7OAd3qpTtFE2N4xZSyaPCokrbyryFWKIkzfRa+WkVuAdvLdJWfxRin+mXYuPkRYpBPlBqni858yDXCps+5tjHnE3m8PAN15o6LAYlXFX8x6uCfOgMjzUuF10hwb2zB5sa824=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BL1PR21MB3379.namprd21.prod.outlook.com (2603:10b6:208:39f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.6; Fri, 17 Feb
 2023 18:59:51 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::3747:daf4:7cc9:5ba2%3]) with mapi id 15.20.6134.013; Fri, 17 Feb 2023
 18:59:51 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Mohammed Gamal <mgamal@redhat.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "xxiong@redhat.com" <xxiong@redhat.com>
Subject: RE: [PATCH v2] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Topic: [PATCH v2] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Index: AQHZQGdq9M/Cyc8biEehOWpQHv+73q7SrIAggAA7AwCAAJpE0A==
Date:   Fri, 17 Feb 2023 18:59:51 +0000
Message-ID: <SA1PR21MB1335FD6892D9E8B4844C0878BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230214112741.133900-1-mgamal@redhat.com>
 <SA1PR21MB1335435701EBB35A9DD35892BFA19@SA1PR21MB1335.namprd21.prod.outlook.com>
 <CAG-HVq-Knhdgwh4QCJ1U_N+bWYavguQ0axmx-TNgF+aCYoS2AA@mail.gmail.com>
In-Reply-To: <CAG-HVq-Knhdgwh4QCJ1U_N+bWYavguQ0axmx-TNgF+aCYoS2AA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d8f1daf1-d648-4108-8d0e-18f59c74b9b3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-17T18:54:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BL1PR21MB3379:EE_
x-ms-office365-filtering-correlation-id: 68f3b573-0423-41d0-8e7f-08db111925f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 62LUQRTvCW7JaLaYcb31M8mN70uUGQRocduJXIJHmiDiFBoFF3Z8H4JHa1g7IwSBgFJz0pmib6ZwCO3/k5QYUZ+kmWVYuBfNB/Gsr2Tez215zU9PbgHNde1N4D1oW+jI6MGnvDW0TObJPq0b3F+mPTbE5vkxeXlwGy/0aTianelverGe+lw3zIUrsEbDKjYohK8/e05pC1nSrWy6drgG/aULSBG3P12QHcjVpyNAKn9XidvDNry6MnTQaBCuuSMBe47KM6oapPq5Rr/gqJJ4ULVP1LNwa0fxs7WNcmnJW3NDNxJVZlwLU1gTdc1Dn9QW4N8IJBUFGbvnVISumwi8CAfAJeOG+0u2iFVzBQr6kPCwDb7XFBUK24A7ebVM7QUYCLBhW0/2G68LIHbMS0P81uoz1Ef3I+hvplAccvmCd8eevm/98DqvN5FTSaDHPgf5lbGk8DmEnT6M5xtuyVkSBCITbzn3Eu1C9TZHNohXE4VJixndE5vJJMk5fSDBuWoSsiYvFne7L/RWAd/bfPwJ/pJWBzh84qOPovcZiEO1azS1jupzyeFpikEMjT22rERypeZ9LgzpLW11qt50ZkXgOWzmssi0M+NsWx5mkUYAMI5RElrqhS+BhV+3CI/VLWwbMF7rgonLT+kcCNk6ceNkqFFFKLfHJEHwAM7qRz+9n5U4Sp3joYCuzWP/LYd5WLEoFxqHaNNOt42PijSiPg6Sq+LEmVwklXw32SwuQLN5bMQJMskku/BD3lw9N8qY9cje
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199018)(38070700005)(82960400001)(82950400001)(55016003)(33656002)(86362001)(7696005)(10290500003)(71200400001)(83380400001)(6506007)(316002)(54906003)(186003)(26005)(9686003)(122000001)(2906002)(66899018)(478600001)(8990500004)(5660300002)(38100700002)(52536014)(66946007)(76116006)(41300700001)(66446008)(66476007)(64756008)(8936002)(66556008)(8676002)(6916009)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXZ6OUFEbXk4S0ZHYzhZS0ZoOEhrSmM2MWRCbjJ1cmxITEdtVTQ5WVZRYjhu?=
 =?utf-8?B?U0xxOW5NY0FDajhraHZRUXA4ckgvbld1TW8rbzk0SWszc0cweHQrWjRiSm1P?=
 =?utf-8?B?ODhVS1lzMkY2ZVVqTGZkOGFCOUpBdDcxV1JkMWRqYmFXZVNYK2dhZmV4aGxw?=
 =?utf-8?B?MTh0TG9CUTlIc05PQTB3NkxTOFlHdUVLWk1FL0I3OVVQQ1prVkxWRFc2alRj?=
 =?utf-8?B?MnNMSVpoaThuaG1td0lxUC9ycFd5MEVVa1EzRjNyNjVOQWlPK1JRZmR0dm1k?=
 =?utf-8?B?SmVuQjVYMXBmRUsxejhUUG1MQ2NvcFNqRkZ4TlZWSzRzU3hNcHNhU0J4b2hM?=
 =?utf-8?B?RGtaNEN6YjlpVjlUYlYyQ0hDcmM0T1FzYVFMdmxUT0N4d1k3TFRQNEJnMGxV?=
 =?utf-8?B?RkZqRVdMUU5SdFJXVDdCTkdPeUREdWJFM0sxNjZQKzNESkVpc2lJUHprRE5w?=
 =?utf-8?B?bHhhTFhHd09UNC9WQzRBemxlTkZkWW9lbml0TWh5b210N2FjN3JsdjJaVzZG?=
 =?utf-8?B?bVl6QkVMc25BMzRUMDRwS0IrRWg4akNwaEw5cm9EQnZTZVk1TDdBZFNXbDll?=
 =?utf-8?B?UWRhVTFzUkN4aTBOdUtnVEdYODZhOWNpM3loREw3Nk16dkswcXh6YzljZHNr?=
 =?utf-8?B?R1RTZGpaSmhNTFF4TzFjYzJyNTcxVDdaWDgwTythYWNXKzdRSzBTS0NvdVNo?=
 =?utf-8?B?QTltTXlvWE9neTBlYzNIbzVPbVA4ME5RWFJWWlo0aS83RTFTek5Qc2tPVmJa?=
 =?utf-8?B?cXowd1VOTStsUytJNmFPTFlseUlOZEdqVG4rVisrRjVMY05KOHFGZTM2d0JI?=
 =?utf-8?B?ZGUvcURzU3Yyek1FWUVSaE51VU1ldldxTkY3RlBwZE8vWDk0aWh6VVQ0MHdr?=
 =?utf-8?B?cUJlZmh4eEhlSVVKK25oQjFrcVZJOUYrWkNzY0dyVDRmOVZxK29UTkZpOWVV?=
 =?utf-8?B?Ym5FVHNvZTFhVWJGVndqc2FpTFZjVlgvNU5WNEdwL01Kd1lzR0paeC81VDV6?=
 =?utf-8?B?cUJjT0NBTkhtTjZUYTlmQ09OUWJ2RkZmS2FDSFpaMXB1YjBnaUFDZHpLUXI4?=
 =?utf-8?B?Z2hTMng2VDZ4aU1sQlY0NlFkcFpBcjYzZXEzZURBZ3pDS3JzbEVyTXYxa2RI?=
 =?utf-8?B?Tkd4U01IcVBYR1RmWWtxNmJnZ1I1bGdvTGVaVmp4eUVOZlA3OEVxY2xhZUpn?=
 =?utf-8?B?QWRobmJzVm16K3dCYTQyYmtUalFWQXVtY0lWUmthMytwcElVSmVtdU1PNytL?=
 =?utf-8?B?Q3FPcmUzWlJzNWVlWXhsVklxMXFCMFJXRlRkWGI5ZzYxbmpiK2ZxZjN5bEI2?=
 =?utf-8?B?bWtZUTI5V3crdzB1cE9lVTV5MWRFR2tqNXA2WklabDB3Y2ZlSWdkVjZrbGQ4?=
 =?utf-8?B?VzVTRVAyaFNZSkVFY2loZ0dzclhKa1dOT3B2dEtUTGg2RHJXbkJtT1QyQzA5?=
 =?utf-8?B?UXlzQ1o0QlZhZWNySEVCb2VvNENZdnE4RXFKU3BRQ0sycGkvUGRtS2M4c3RN?=
 =?utf-8?B?N09JZzRWQ1ViNXR2OGtWeDdPSWFsT002aG92dWdHMTdxMmhNbUtrNHBvdmxZ?=
 =?utf-8?B?SENiODVZeER4ZVZvTHBERzdQWktoWDh4Q1gwZjl4QjgyVVp0a3lMTkkyNHFw?=
 =?utf-8?B?VlNabUlBQjRGZTlJUWFGSzlieGNva203bUdqY0IwQjNNZW9sWWh2dnFUcldO?=
 =?utf-8?B?enFSeTM4SnNXOGxQOEVKVmZHUnh5Y3cweGJZL2NFWjV4clAxNmxlMmkyZmZX?=
 =?utf-8?B?MHhhbTcwaXB4aXJ3aUYvblNUaG02WHIzNVArUnhqaWtaNk4zR3JNVEFlYytR?=
 =?utf-8?B?MmlzQ2pPa1NZTmlRSXg1NjRhemh5VHFISDcrUzhYMkFidUY4VFZYa3FqUjQx?=
 =?utf-8?B?UDMraGtCWlllc0UrbHI3S2QwYUtrRUhkcjZQRTA1czZOR21DM3d1Z3E5OG0v?=
 =?utf-8?B?U0Y1T21yN0o5QnJxSk1PSFZQdldJSDB0UXUwZ2ZLVFU5L2pydlltR0p4WUdp?=
 =?utf-8?B?WWZSTjB2TGNER3k0TitjY0VVNFFhc0o5MkVTTm9EVm1TZlJ0T0NaL1RFVWlV?=
 =?utf-8?B?YkZRanEyNTlYdWYveWtJVEVGQVRwSG40R05ya1FUNi9rTDBaa0R5dlZtcVBu?=
 =?utf-8?Q?zuiN72cw3Jcgm/1ckbpBACp1R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f3b573-0423-41d0-8e7f-08db111925f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 18:59:51.1030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iG9Iu9+8ralvz+vyrauF8AT+brPTn9KzpLfnr1XAYL/ihkSa+3t76Gt3aWC3HBWdU63Xcww3gVfxv8p0pfwQjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3379
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBNb2hhbW1lZCBHYW1hbCA8bWdhbWFsQHJlZGhhdC5jb20+DQo+IFNlbnQ6IEZyaWRh
eSwgRmVicnVhcnkgMTcsIDIwMjMgMTo0MyBBTQ0KPiA+ID4gQEAgLTQwOSw2ICs0MDksMTAgQEAg
dm9pZCB2bWJ1c19kaXNjb25uZWN0KHZvaWQpDQo+ID4gPiAgICovDQo+ID4gPiAgc3RydWN0IHZt
YnVzX2NoYW5uZWwgKnJlbGlkMmNoYW5uZWwodTMyIHJlbGlkKQ0KPiA+ID4gIHsNCj4gPiA+ICsg
ICAgIGlmICh2bWJ1c19jb25uZWN0aW9uLmNoYW5uZWxzID09IE5VTEwpIHsNCj4gPiA+ICsgICAg
ICAgICAgICAgV0FSTigxLCAiUmVxdWVzdGVkIHJlbGlkPSV1LCBidXQgY2hhbm5lbCBtYXBwaW5n
IG5vdA0KPiA+ID4gYWxsb2NhdGVkIVxuIiwgcmVsaWQpOw0KPiA+DQo+ID4gV0FSTigpIG1heSBi
ZSB0b28gbm9pc3kuIEkgc3VnZ2VzdCB3ZSB1c2UgcHJfd2FybigpIGluc3RlYWQuDQo+ID4NCj4g
TWFrZXMgc2Vuc2UuIFdpbGwgdXNlIHByX3dhcm4oKSBpbnN0ZWFkLg0KDQpBcyBWaXRhbHkgc3Vn
Z2VzdGVkLCBwcl93YXJuX29uY2UoKSBsb29rcyBiZXR0ZXIuDQogDQo+ID4gQ2FuIHdlIG1ha2Ug
dGhlIGxpbmUgYSBsaXR0bGUgc2hvcnRlcjoNCj4gPiAgICAgICAgIHByX3dhcm4oInJlbGlkMmNo
YW5uZWw6IGludmFsaWQgY2hhbm5lbCBpZCAldVxuIiwgcmVsaWQpOw0KPiA+DQo+IEkgdGhpbmsg
dGhpcyBtZXNzYWdlIGNvdWxkIGJlIGEgYml0IG1pc2xlYWRpbmcuIFRoZSBwcm9ibGVtIGhlcmUg
aXMNCj4gbm90IHRoYXQgdGhlIHJlbGlkDQo+IGlzIGludmFsaWQsIGJ1dCB0aGF0IHRoZSByZWxp
ZC10by1jaGFubmVsIG1hcHBpbmcgaGFzbid0IGJlZW4NCj4gYWxsb2NhdGVkIGJ5IHRoZSBzZWNv
bmQNCj4ga2VybmVsIHlldC4gQW4gaW52YWxpZCByZWxpZCBjb3VsZCBzaW1wbHkgYmUgdGhlIGNh
c2Ugd2hlcmUgcmVsaWQgPj0NCj4gTUFYX0NIQU5ORUxfUkVMSURTLg0KPiANCj4gTWF5IGJlIHNv
bWV0aGluZyBsaWtlOg0KPiAgICAgIHByX3dhcm4oInJlbGlkMmNoYW5uZWw6IE5vIGNoYW5uZWxz
IG1hcHBlZCBmb3IgcmVsaWQgJWRcbiwgcmVsaWQiKTsNCj4gd291bGQgYmUgY2xlYXJlcj8NCg0K
SU1PIHRoZSAncmVsaWQnIGlzIGludmFsaWQgaW4gdGhlIHNlY29uZCBrZXJuZWwgYmVjYXVzZSB0
aGUgc2Vjb25kDQprZXJuZWwgaGFzIG5vdCBjYWxsZWQgdm1idXNfcmVxdWVzdF9vZmZlcnMoKSB5
ZXQsIGJ1dCB5b3VyIG5ldyBtZXNzYWdlDQppcyBvayB0byBtZS4gSSBqdXN0IHdhbnRlZCB0byBh
dm9pZCBhIHRvbyBsb25nIGxpbmUgb2YgPjgwIGNoYXJhY3RlcnMgOi0pDQo=
