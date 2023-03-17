Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810456BEA4E
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 14:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjCQNks (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 09:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjCQNkk (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 09:40:40 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020017.outbound.protection.outlook.com [52.101.56.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CA5E6FEF;
        Fri, 17 Mar 2023 06:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWNA+F1Rh3C6D9CgM7xPshB25yrUUOYmHAV6/YoPNv6Tj5Bz9MvzXhjCibPDZOAvk/r4Cqv+mFTWG0VSOaFQN2cDVN0ogz4KUiKthX3pwyvmR36s1XOHaBiwnOfO4EmcrQJq8RszKSKGpexQXXyJ4mDA3qPOFG2thKuIzoCad5w5f0nqanSbtT9fTnaLVcJBhMRPbsn+USeFqX2sWhcdULU+bsAgbR5sE/3g+KUQ+/73fgq5BWyOPHjmfbsj342YVUVq3Dl5eddLPhSCNE1OmR0iYQfaJehxpwv8Qx28YtSQCSEH9a4oXIt7xRPEACE4YKsVsF29IRWQfUDbFfE7lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IWOKM6zPJBJVIk7WE8XCPxtkaO83y25hU/EWFlYtB1I=;
 b=UAXBMX+8WhUsOFeHdkkHjwcylB5VYPKHjSdtBz86ELCLTtmg7VRODI0YNKMJcqGDVHwcdqmzcwY8Jz8H7MYO1+RBrxrI/QTauxJ0d2KDuBKXKDhCjkhQfOt95RZWeapuHwbs4S8271RAgiFdZeINlIMoWoPbh5qTO40JbnnZhzO5k0BCFNhtBCNh9CZd90sIjInMja5GXuqAqTOF54dAn7cycI7cglXzyNY8EDzy23ng1XwDO8wu0BgOIK3WNgCO1G36g1/gF2fc8fbAS6H/Evc/szbKRxXbdPSUs0IJzvNU4dfJMgRWWtS8spR3F5JpINQTrOWFjIg0RC8E3oNCTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IWOKM6zPJBJVIk7WE8XCPxtkaO83y25hU/EWFlYtB1I=;
 b=Qn0YjA7gm9uRPKPq/Rnh9ppyW/VU83cBBOCqxmYhKgRAVQO5vjJqOz13hcUOcg4aPf1iU9DFAW3gjIe7ILA8NcrhRp4aAt0HsTD+z9eq2+tl3+T/Jg5wj8CE7qk1vKaROV89njJT9MmhhHS6fPVGrr18cnuJqP6E87BDZ1295lk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH7PR21MB3922.namprd21.prod.outlook.com (2603:10b6:510:24c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.10; Fri, 17 Mar
 2023 13:40:25 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%6]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 13:40:25 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@kernel.org" <jpoimboe@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: RE: [PATCH v2] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Thread-Topic: [PATCH v2] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Thread-Index: AQHZU2hjnJn1KDSyxUy64FYlyEIrhK70go0AgAlx+oCAARAiMA==
Date:   Fri, 17 Mar 2023 13:40:25 +0000
Message-ID: <BYAPR21MB1688673F3E49C9944E892894D7BD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230310152442.cbrjise6uex4ak4x@treble>
 <20230310154452.1169204-1-gpiccoli@igalia.com>
 <BYAPR21MB16888EBB51D1597F9B9C212FD7BA9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <a1f40654-b3cf-5c77-561e-056f47cbff61@igalia.com>
In-Reply-To: <a1f40654-b3cf-5c77-561e-056f47cbff61@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3a79ec36-be05-4c1d-8aea-cf63db78802f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-17T13:38:20Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH7PR21MB3922:EE_
x-ms-office365-filtering-correlation-id: 0bd59f97-3d9c-41b4-4427-08db26ed29fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZrYKGb0yyGm1i/nDAcxy2TsokZ3sa0kjz1085M8cl3J7/WlYHvAkH9K5C2kXH48jYBZjeWXEIdHlyHZ3kv9FWy6JlzCfx/H02orNNxEzaqEkhG9yyVghsFntSzwDFPcxDHBMDl0VqMikeC/MEIEq4T2JIo8BffdMjiOarTcnRDNb41YA6+P6DS2CJVGcyV7TO/b40i/lwPvyblG4dZyd+HxSy30fkHbQ5p9VrQmH1akNxBgn2uaxxTq3dD9zlxXINtsUifBj+OFGD/r3agsfTR62okajoeNAyUZocX/nAcwSxQczrIbPapNcwWfK9hTlKLqAtsSu2pvd/K+F2zZpZcskRCFjtEYWoazB45hcoV8JYrolBBxyvRlk/SL5Dz5AEl54oXFXAOriIxI0emY3CO2XbCBmt21FSTORDykH+Q7MKkA1ERAOau5CA0g1Vrv5/+G98DvU65fbpatcpUl+W5zc3qv57iXbpEgQXBgl5HHufRZzt5Muf78o0kNb7UdZ+0ROdbgGJMu4hT8fDylH3MJc8VE7dUtW3M6+q2CsJyv6ZJmC0r/jc0JO0aX6ju/R1rzryHCUtK9n0Q9wwbi1PEDUfYnJHaYmXeFv2l/nk92U3xN1e5QPCPTQsb2/zhTMo3kdbdMbPl0+r7wPkaZYAa+tPvejlasP92/EC4tzfl5RpaQYhgVdLcqc96b5IikVqUsja+KMKkTGe1KqwbRdnH/WOc6LKhOnx1MZB/uuF3N7cqzzT4d6sGgxu9C/5ZcR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(451199018)(38100700002)(82950400001)(82960400001)(8990500004)(122000001)(86362001)(7696005)(71200400001)(478600001)(10290500003)(2906002)(9686003)(54906003)(110136005)(316002)(55016003)(33656002)(38070700005)(53546011)(41300700001)(66476007)(8676002)(64756008)(66556008)(66446008)(76116006)(66946007)(4326008)(186003)(4744005)(52536014)(8936002)(26005)(6506007)(7416002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlBZdVcxbmQwZEpWSFJGK09QWjhXaFVhd0N4bXJtUWJYbmR5SGQwN0Z5aERv?=
 =?utf-8?B?ZkpuVjQwRCs5TUVtTURYUUtGaTlaUGUrME03R1gwY0JZcksrOGpNSm5xR2lh?=
 =?utf-8?B?NDlmemI3YmozY0k4WnIzOHIwYno2SnhrZ3QzVkEybkNvOUkzWTZhWmNnZGd5?=
 =?utf-8?B?NU95UDhWSDFaaVkvcXF4RUZhSlNxaVRHbWZEOVlUTnJRZzVhMWlCZWJnME9z?=
 =?utf-8?B?ZHMxZDNZdWVsT1kxTG5tcjBGcFFMR1VRWmhLYXVyMmRjTTBrSmhiMEFNcnZI?=
 =?utf-8?B?WitKVUVRMjduZkVmemlWaTVUMzNNVkdlbjZyQmg4LzZzY2VRbEthN3MwWm04?=
 =?utf-8?B?d3ZrM25Oa2NKeUdGSDBWbXZyNWlqN29Yb0pxM1ZQdnZBNDdKcm03N2hDOVBX?=
 =?utf-8?B?NDFQakFrZHJCTmFBNElzNDlDRTlYN3QwVStickYyV1dVVGgwNnRHNTE2TW14?=
 =?utf-8?B?aUxvSkNjaUd1RnNxbnl2SThJWjBBcjB4QnMwYk9XL3F5OXJpbUxLOVR4MWVY?=
 =?utf-8?B?QkpjWS9jTHlOdTdTSklkNjBpRTd1Nk9BOWU5TmVoUE1UVzJHVU53WUxDRHl3?=
 =?utf-8?B?VU41ZXNjcytxZzZsSWQ0WDF2OHF0WUJVY0Y4VStNblVldGMwSDZJRG9wWlhS?=
 =?utf-8?B?QWszME0yWTQ0YVZORkRLbjJESzRaSzdic2JmdGRnOWRkR3pqQ3o3WGo5cGV5?=
 =?utf-8?B?MW14NEl2UEpEOHYzNjB4M0d5Qmc5MjZvbGJxQ01jUm5QY0ZjY1ZJVEpwbnNz?=
 =?utf-8?B?UUsrc3hOWkJuR1JDdm1MOFI5UlZjbURKNjMwTDFqYUlnWjhBR0dZQXhmazdP?=
 =?utf-8?B?VTRmbWY4anBUd28xVDdRT1ZuNVg3aUNZTHJoVlJyTloxRTk5T1F5dGJuSnhJ?=
 =?utf-8?B?OW9Jdk9hOWo5UytoNjZUQ2VsbTlWNDFJSGJLbFNrUHNwa0dCL1Y0eVRKVHhw?=
 =?utf-8?B?dmlvalVZOWtySGVqWDRsUVQ5WFpReFVxZXFoMTNLanNEZkZBRDBqS2tOQno1?=
 =?utf-8?B?TlhkbVlyMjVhZy9lb3B6U1NicWV4bUExK1hZSTJwVUMzMk1Nd29tYWtvNXFO?=
 =?utf-8?B?cCszTHVFQnhabUZtbWlObEhlWlBxYVZLcVZuRzBiRW9zM1dZbU5WbHhna3ph?=
 =?utf-8?B?NXFMcUZWRW5nMHNsNHA2UVo3VjkxM0VHcFhkR3N6a3hrQ1pEaDQ3YWJNYnJB?=
 =?utf-8?B?VmpoY1dPUWlITUZHWS9WVlFMQ0RJWkxEYjVQc3QrcmYzUER1b1llTzBVYjJr?=
 =?utf-8?B?VVNFWFZpZWdKMmFrL0loQ1N6a3dvNStEK3EwY014c2VaMTJSYzdGVFBHM2k5?=
 =?utf-8?B?L0d0aWpuc2FxRjMyaEcycFFQNmNaRGtIbGpsVkRTN2hQTUFpbHU4UW9TYWhX?=
 =?utf-8?B?ek5McWE1UlYyV3FEaXJuOXBTTU1OY1U2bWgweU92aFBCLzlObVdidDBFVjNK?=
 =?utf-8?B?Y3NpVXlTdGpVMGxqaWlPVkpyWWFhNElxWisvUExlWk91R1g1SmQyUXVhSXRV?=
 =?utf-8?B?eGFNaVkrb2JVTWc5MTRIVE5OMVVLV1NRY0JlNjhSNTBENXZFSGJ2Z3pVYlVh?=
 =?utf-8?B?OEY0M2c5a0R4UkEyTVQ2RmRYRDByVjAxazIxeE5uTzN2TGVNU0U2N3pYWmYy?=
 =?utf-8?B?enA2WG55M1BUTkdmdUFDSDBobWE5UldBWlBGNExHdFVtYWFwNkxEZzJQVG50?=
 =?utf-8?B?YmZLTGZ0SXJGQ2ZscVBGRytuMFU3U0ovSFBGWm5hUE5mZmdqWEh0WjhnRVU0?=
 =?utf-8?B?dDdQK0wyTXgyWUdNeS9zZittT1pZNnRXclNseUVZaXk1RHdFNDNrNHFvU0Rr?=
 =?utf-8?B?eWVBd2NHaFpCejVOVXRmbTREUEU5OFB6Z3hOdW0rb3E5a054WUF6bkU1K2Z2?=
 =?utf-8?B?aFMxK3hjZmRlYXY2NjRsMFZhSDBRR3hKbktLekZFM1Y4bXJQbGlSVXJGZVVk?=
 =?utf-8?B?Mmc3MUNnL0NUakFJaVhNR3NBZEkzakFEK1V4MGw4K3U3K0Vwckx3MnFRNVc1?=
 =?utf-8?B?V1VJaVhvWTRnWTNQUjJKM3kzMk93dUhKL0dnR204bHc5MW16Nk9lSXFoUGhT?=
 =?utf-8?B?NlFXZ24xcytUSkRuazIrSFBMRmlpdEdJU2U2dHpUbkwvWXo4V2ZwTHBaN0F4?=
 =?utf-8?B?SVBnc0JsSTRNelhxbmxrYWZiUlhtbWs0ekxMcC9DYnN2bStRdCt3endPOHIr?=
 =?utf-8?B?R2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd59f97-3d9c-41b4-4427-08db26ed29fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 13:40:25.6172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I/V9KRIbzxT3GFRmrMGf+TElEUlmAsp/BXfC8nIqAVg3UOtLYG1UBtyjepXWg3dtgbpV9tIYZV1BV7U89TrqptsVIzL0qHiT4/s2OENvhwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3922
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogR3VpbGhlcm1lIEcuIFBpY2NvbGkgPGdwaWNjb2xpQGlnYWxpYS5jb20+IFNlbnQ6IFRo
dXJzZGF5LCBNYXJjaCAxNiwgMjAyMyAyOjI0IFBNDQo+IA0KPiBPbiAxMC8wMy8yMDIzIDE4OjE3
LCBNaWNoYWVsIEtlbGxleSAoTElOVVgpIHdyb3RlOg0KPiA+IFsuLi5dDQo+ID4gSnVzdCBjdXJp
b3VzOiAgU2hvdWxkIHRoZSBhY3R1YWwgZnVuY3Rpb24gYWxzbyBiZSB1cGRhdGVkIHdpdGgNCj4g
PiBfX25vcmV0dXJuPyAgIEluIHNpbWlsYXIgc2l0dWF0aW9ucywgc3VjaCBhcyBzbnBfYWJvcnQo
KSwgdGhlDQo+ID4gX19ub3JldHVybiBhdHRyaWJ1dGUgaXMgYm90aCBwbGFjZXMuICAgSSBkb24n
dCBrbm93IHdoYXQgdGhlDQo+ID4gZ3VpZGFuY2UgaXMgb24gdGhpcyBxdWVzdGlvbi4NCj4gPg0K
PiANCj4gSGkgTWljaGFlbCAvIEpvc2ggKGFuZCBhbGwpLCBsZW1tZSBrbm93IGlmIHlvdSB3YW50
IG1lIHRvIHN1Ym1pdCBhIFYzDQo+IGRvaW5nIHRoYXQuIFRoZSBmdW5jdGlvbiBpcyBub3QgY2Fs
bGVkIGluc2lkZSB0aGlzIG93biBkZWZpbml0aW9uIGZpbGUNCj4gbm9yIGV4cG9ydGVkLCBzbyBJ
J20gbm90IHN1cmUgdGhhdCdkIGJlIG5lY2Vzc2FyeSwgYnV0IGdsYWQgdG8gZG8gc28gaWYNCj4g
eW91IHByZWZlci4NCj4gDQoNCkkgZG9uJ3QgaGF2ZSBhIHByZWZlcmVuY2UuICBJIHdhcyBqdXN0
IHRyeWluZyB0byBtYWtlIHN1cmUgdGhlIGRldGFpbHMNCmFyZSBhbGwgY29ycmVjdC4gIEknbGwg
ZGVmZXIgdG8gdGhvc2Ugd2l0aCBtb3JlIGtub3dsZWRnZSBvZiB0aGUNCl9fbm9yZXR1cm4gYXR0
cmlidXRlIHRoYW4gSSBoYXZlLg0KDQpNaWNoYWVsDQo=
