Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61B779787
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Aug 2023 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHKTI1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Aug 2023 15:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjHKTIQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Aug 2023 15:08:16 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021021.outbound.protection.outlook.com [52.101.57.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9BD19A5;
        Fri, 11 Aug 2023 12:08:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjrQv2EuUArRs43neRpTa4etw/isLh0WXNZzmbziJa2nZVSKVbtKiOc3Rh7pTq2eJwP+PHre5gVrvWXavNQtb0Pc1lHT+93LjuP1WmL8KLS3n6rYS66IBFt8f7z5RxRPOy/N/XGvMRvsPzAIBIReblvsJ4oy3OiLp2Nu1prC6gaF+N+EQlh0+g1sZEwYjLcEFoTklUA019GtCTZjALMq9m+cANRFwRmQMsBl4yST3ujdzeC2UwC/sWPm0j3lbpP+x8Yf1jYnahBaRNkahbk/JV4YA7U/uqcA9Qh4CUjo46Z4oYfgvN/09Q8cDLP/BQ6PLtK5ovaPDJeoqQzcUpTUqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sobRaAZv44thMRHdMH0Te/YIBQqGOPAWbsqUoHB+0g=;
 b=DXmTqOLauKs4BBZg4FRDeSmtE58P9J0MHUe8BlZJQ6dtg1+fqFVhgLp2Oyltv6mEh22A8JbSXikgavuYsNuQpJlumKI5uRhK3wNNjzkZYrzSwJtKUBsYby7tbbiZHrcWBhtubWiQzCJH+N+zcLatHaMBD+p74vYNzbfcY1c2JjF6t/9O68upeRaxSFhJcJXY89XDwR+E/ZxH+R5xs1rdu4ONY9Ew7HPhLXjQdxo7uhttFMHq5+dWizTJQS1MlILq1faQ6gBJUFqJnBdOFoy/UAm/LxFlIy1dIByt0G/u5r9vb7LnxGKu6yHEmG2FmO22qTNihbke/oDukxqnZhARhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sobRaAZv44thMRHdMH0Te/YIBQqGOPAWbsqUoHB+0g=;
 b=AqgeKtJs7tW/4BQT1oBVTtQl8hcmGsuZiBrqts1AhZAPteCGqb6UplIJW8dfG6c9h7lZwE/zMoMey74sksR4RyctPURC9ieMV9N42y57x7eqeFvT8w2uuJmh9vPg6I7D3SEKhexPkqVkWBAL+INySyMdSVaDQlpDPkr037Z7c4Y=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by BY5PR21MB1394.namprd21.prod.outlook.com (2603:10b6:a03:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.9; Fri, 11 Aug
 2023 19:08:11 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::d4d:7c16:fa93:9870%5]) with mapi id 15.20.6699.009; Fri, 11 Aug 2023
 19:08:11 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de" <bp@alien8.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>, jason <jason@zx2c4.com>,
        "nik.borisov@suse.com" <nik.borisov@suse.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        Anthony Davis <andavis@redhat.com>,
        Mark Heslin <mheslin@redhat.com>,
        vkuznets <vkuznets@redhat.com>,
        "xiaoyao.li@intel.com" <xiaoyao.li@intel.com>
Subject: RE: [PATCH RESEND v9 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Topic: [PATCH RESEND v9 2/2] x86/tdx: Support vmalloc() for
 tdx_enc_status_changed()
Thread-Index: AQHZzF1+hjKaMR43Pk+uAucN9xUzca/ldLlA
Date:   Fri, 11 Aug 2023 19:08:10 +0000
Message-ID: <SA1PR21MB1335244866EFEB269445DBDBBF10A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230811021246.821-1-decui@microsoft.com>
 <20230811021246.821-3-decui@microsoft.com>
 <69b46bf3-40ab-c379-03d5-efd537ed44c7@intel.com>
In-Reply-To: <69b46bf3-40ab-c379-03d5-efd537ed44c7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=38caf044-919d-48fb-9571-c71b973aa243;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-11T19:05:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|BY5PR21MB1394:EE_
x-ms-office365-filtering-correlation-id: c8baf7c6-71df-480d-99e3-08db9a9e4e2a
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vj0WuBxeU+D/v7lHUWi64EYwvv/aPUzsoXum3lF2qQU92v0F89V1B8dvjd9XWONUFWktaUwGVtbcEmG6IxmIxwr7uH6sUnqNE8QiRSpBayOtVJuON2YSLEIksLmW62l917HYRHHdrrF3DB0nfMk1JwYBZvHcEF1qgl+dE/ZA3FEMbXGTwoFz6FZdNjdcS4mAYuTL4EEn56lO2yfpeYhM8HZH/rA76g8iVrxeRR37kPWpaQZ0ywilWR4qD364kMWpq0Syme0jcoOVx2shtm/FRLnG1Ia46oJUoklAb9fABHVZLehfa2kxx4qvsb1qJy2WBj/xHd3Y/yQL+9208n807amUbPH/o9TaBF8Ouoc20/W8TJ1P9lAB1kv0f5dhdxIR7mDXY6XYCDs2OHCtJYe6jzTYUY4CHlaVbkmWpo0APCGQIyNJ6wL+n6Jz8qI1zd0HNqRj7Hn30c2vOzat6QwYU6rmWh0QjX7CsnkBoyNCiSHBwK98PvJD7vVAPZefd+xH9XG6sJJNducLfVcjs7R42PpbbZ/7bAV5OGB1uXzbCQP4MudqXlyne43mMwMXe1rFfZE72VWL3BsD68Y9oumOohRd/C24CV75JB4OT1hwkv6GhYPxyDvy+sAtlRJE5oZ7nVuhvL6d8hnnMERBDlLkHld5HG7rYaVZ42IozX0WqZEBUWrIr6OrMc3lneT7IncdajkvdnF3yi7CU05ChaCGsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(136003)(376002)(396003)(366004)(186006)(451199021)(1800799006)(54906003)(110136005)(478600001)(10290500003)(12101799016)(6506007)(26005)(71200400001)(55016003)(82950400001)(7696005)(9686003)(2906002)(38100700002)(82960400001)(7416002)(4744005)(921005)(38070700005)(8676002)(8936002)(41300700001)(52536014)(5660300002)(122000001)(8990500004)(33656002)(316002)(6636002)(4326008)(86362001)(76116006)(66476007)(64756008)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVdManhxMDc5TkQ2RGZkOWpLdldnNHpENTRrRFlTSTFBUnVhZG5oNUFPRlc1?=
 =?utf-8?B?VXZMZFYwSmpueENjWVRnUms2ZHZqVzlwSmFMSHVJb2lEZUg4SXRtSENKMTA5?=
 =?utf-8?B?T0hJaXhNdVJVY1FZVG9ob3A2VzR2VjhXcmluR0FSL0sxRXhTdVV6T2pGd3dS?=
 =?utf-8?B?Sm93N0ppYmxWTk9ZYW9naHF0R0FQS2QycE01Q1FXaE9NTkFweG5GRDltVlVO?=
 =?utf-8?B?YnVWVDNTTUdzNndOMEZHaktQY1FYK2UvejBZTjZ5WWYySUpjOTI3OG1LdzBs?=
 =?utf-8?B?UTVLaWRoanJ5dnk2RCtSalZJVFkrWnFGdUhYb2VUL2VFa0JDWUJXVStTMVRz?=
 =?utf-8?B?WGpqR0RFMkJ6Y0F4c1Y2Y1J2NlRzZVZpMHVWN1pibWFUSUxBK1V4ZitteXZY?=
 =?utf-8?B?bHJsZWFQYXhhS0JCK1cyNDEwNmlQcktna3VNajRuc2Fkc3RCKzlpbzJXKzNH?=
 =?utf-8?B?MXFRTzZIbVJJY3plWWNkWnozb1FYai8vbkJiUDUwczRWMWNrMzZndUl0V2pG?=
 =?utf-8?B?Rlo4QmRrNG9TSklta2dHRHFJaGdsRmUzSDIvN2hxMERBT1JWeHFtL2c5Mjhl?=
 =?utf-8?B?Qi9uM3I2Q2IyK3VRQkR3VWFvNEdTaUZyQS85N01WQ09xdEVPejQrbEZjWEF2?=
 =?utf-8?B?NTVBWHFJZnZpUE5jRXdpRHNvdkI4aVRnRzhSdE9ER3dXb1JYUVpaVnVrMG45?=
 =?utf-8?B?bUFZM3NuSjF3UkI5TUpsQlBZcFpSdTdNcGhEK3BvSWRoVVBHSnR3TitaNGc5?=
 =?utf-8?B?bGVwL1orKzUxbkV0R1lZN3dCVEhRN1ovRHpCcCt4L283QnEyaDdNV1N1QjZG?=
 =?utf-8?B?T1l5TDJHV3hSVnNRcEZkWTdodzZvbmpVbWZyeEM2WVRHRjRCSi9YZ3NseUk4?=
 =?utf-8?B?S1ZIcEw1bW51aXJ2Y2RVSlJRc2s3UFEwTU9ad1BOUVhaQWVkd3pCelBtcFQ3?=
 =?utf-8?B?WDFnSU9tMmhJWjdidzRYTjhzbjhFS0o2UEc3enM3bkRPRWRZcXFtZzI5USti?=
 =?utf-8?B?U1N0a0NoamhMakFZRm5EQ1FCSjlua1JOWnA5MWgvblRacEFKb0VCU0VrTi92?=
 =?utf-8?B?YXRNMnBJN0trcWN4SGpvS3FwWjU1SW5GWjZiQnRJVktNYUtIaFYxbHFPTTlT?=
 =?utf-8?B?WHNLUzFxOFpRM2llQXFQVGJsd2RLVTJjVGdOMVNKbXFmTkQ0OUp3MTVUbFFr?=
 =?utf-8?B?czM1cDVuSVI0THNDRTlSR3hZK21SMVluVllHM2twdWdwKy9OUjMvTGMyOUZQ?=
 =?utf-8?B?NGcyNG9MTG1Lb2FVU0VEYkpYVHVVbVQ2eDFYSjlrK09LYVFNNi80Mm9XK3Rj?=
 =?utf-8?B?N3JtRS9uZytJck1lc3IwSGZDY2dMSU9YSUdFbXRWcERRMFRUTHhheHR4akp6?=
 =?utf-8?B?SEd4K3M4WjNCQS9jSGMxd3pTT2NTdnNZNXM5TXZOZFVaMFFaME80T2dML0hs?=
 =?utf-8?B?ejQycjZvNTIvRm5RanRvRURDbXdodyt6WUNlTFU2cGNKcTIwU3dTbGZ2N3JI?=
 =?utf-8?B?djBoN1JwQmZFZnd0YmgrMTVxelNoU2c1Uk9sbytnSG1MVnFORC95WlB0cDZS?=
 =?utf-8?B?NW1rKzI0WW5Qd0Z3ZC83Vlkxa3k5Ty9rMk5SZGEzYyswQ05yVVhMa2VLZEJr?=
 =?utf-8?B?VTI0aVFadUtVVVROcVdNNEoxSnBGbmR4V3ZyREpTMnRFVFNYTHZhZElNK1d4?=
 =?utf-8?B?ZmJCdmFWd21LdXVYbHpDNEhPb1ZLM25yaURTblJOTWRmcTBTMDl0aXFXK2Iw?=
 =?utf-8?B?MXV4VEFMMHd5R0NrTDZIVzVkVnVFVkgwd0tzUWZNMjFteTUrVCtPem5rKzMx?=
 =?utf-8?B?VTFES2NScWZvUjdjcDZMK05zVEQ4WmJmOEZWSy96cmthUFhlU2I1ZS9HbU9w?=
 =?utf-8?B?T2l6UWN6aFFEdWNRTDVSLzNhTU96ejdYSTJRcVZHcWZOWDhqQnZuVmJjWjVi?=
 =?utf-8?B?RWZWUy9mbVBSUXkxL1JDZ0ZLRHlFRzNvN2dSWHoxcEtDNHh0TDB4dmNoYXJy?=
 =?utf-8?B?NkVYcjl5cnlqQXZRZi82UWx2Zk5nYWg4d2paYlY3NDJUWXJ5UDk3aFFaT0c3?=
 =?utf-8?B?d1E2Y3lMenlZNXFVVDcxbDFlcThGTHF6UmhKK0orVkVvcHp3UWRZTjNrbHNt?=
 =?utf-8?Q?zlh9/G5/8oOFwNXHHYlK61RFD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8baf7c6-71df-480d-99e3-08db9a9e4e2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 19:08:10.9594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jtvNcmkHZcW/0bpaZrJ7tK8SjIidFVSo3bbAaw8v2sqjNbA2NHToCOxwm/v8wUhzoKX9tiUDq6ZAVm2iySJiGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1394
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEF1Z3VzdCAxMSwgMjAyMyA3OjEwIEFNDQo+IFsuLi5dDQo+IFRoaXMgY3JlYXRlcyB0d28g
ZGlmZmVyZW50IHBhdGhzIGZvciB2bWFsbG9jKCkgYW5kIHRoZSBkaXJlY3QgbWFwLg0KPiBUaGVy
ZSBhcmUgdHdvIGRpZmZlcmVudCB3YXlzIHRvIGRvIHZhPT5wYSBjb252ZXJzaW9uLCBmb3IgaW5z
dGFuY2UuDQo+IEhlcmUncyBhIHNpbmdsZSBsb29wIHRoYXQgd29ya3MgZm9yIGJvdGggY2FzZXM6
DQo+IA0KPiAJdW5zaWduZWQgbG9uZyBzdGVwID0gZW5kIC0gc3RhcnQ7DQo+IAl1bnNpZ25lZCBs
b25nIGFkZHI7DQo+IA0KPiAJLyogU3RlcCB0aHJvdWdoIHBhZ2UtYnktcGFnZSBmb3Igdm1hbGxv
YygpIG1hcHBpbmdzOiAqLw0KPiAJaWYgKGlzX3ZtYWxsb2NfYWRkcigodm9pZCAqKXZhZGRyKSkN
Cj4gCQlzdGVwID0gUEFHRV9TSVpFOw0KPiANCj4gCWZvciAoYWRkciA9IHN0YXJ0OyBhZGRyIDwg
ZW5kOyBhZGRyICs9IHN0ZXApIHsNCj4gCQlwaHlzX2FkZHJfdCBzdGFydF9wYSA9IHNsb3dfdmly
dF90b19waHlzKGFkZHIpOw0KPiAJCXBoeXNfYWRkcl90IGVuZF9wYSAgID0gc3RhcnRfcGEgKyBz
dGVwOw0KPiANCj4gCQlpZiAoIXRkeF9lbmNfc3RhdHVzX2NoYW5nZWRfcGh5cyhzdGFydF9wYSwg
ZW5kX3BhLCBlbmMpKQ0KPiAJCQlyZXR1cm4gZmFsc2U7DQo+IAl9DQo+IA0KPiBOb3RlIHRoYXQg
dGhpcyBhbHNvIGRvZXNuJ3QgYWJ1c2UgJ3N0YXJ0JyBieSBtYWtpbmcgaXQgYSBsb29wIHZhcmlh
YmxlLg0KPiBJdCBhbHNvLCB1aCwgdXNlcyBhIGZvcigpIGxvb3AuDQo+IA0KPiBUaGUgb25seSBk
b3duc2lkZSBpcyB0aGF0IGl0IGNvc3RzIGEgcGFnZSB0YWJsZSB3YWxrIGZvciBkaXJlY3QgbWFw
DQo+IHZpcnQ9PnBoeXMgY29udmVyc2lvbi4gIEkgY2FuIGxpdmUgd2l0aCB0aGF0Lg0KDQpZb3Vy
IHZlcnNpb24gaXMgY29uY2lzZSBhbmQgbW9yZSByZWFkYWJsZS4gIA0KVGhhbmtzIGZvciBpbXBy
b3ZpbmcgdGhlIHBhdGNoISBJJ2xsIHVzZSB0aGlzIGluIHYxMCBzaG9ydGx5Lg0K
