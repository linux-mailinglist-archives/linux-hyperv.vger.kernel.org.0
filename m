Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEE777D24E
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Aug 2023 20:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbjHOSqD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Aug 2023 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239603AbjHOSpY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Aug 2023 14:45:24 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021024.outbound.protection.outlook.com [52.101.57.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECA32D6D;
        Tue, 15 Aug 2023 11:44:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrP1nULE6ku046rp3KAs8/1oSXgbGiyuKrUD0iMqN25JlzGC7XJwR2WmfMUqIbUrqBv4pISkoaX7CarDOFk54cSiYt6gY6ypZZByOSWKcUDCr55S0q+C7LIfD+BPsIdly4eA6ETNmhSfyn9aeEDcUJtmYAaxJQqnwwHgaNTQNtEc8kXDuGquxFU05iVVMCfqlNZqlVNC9f5PQz9hkCvfuI9aqoLdBNy9JAnQ7v+H6gOYq4YsuuQ8pF9bszEuCjAj7wD1T84/hKImm1b35L7z+zgEO3Z2G8NxHi4xRyeuQE3U0ccWHmuAEr55zjq2GKYRS/b7YR/AWFfcszwqgJEE1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ug3kGSFbTnjlHjs5EQ22zfgErmlaCzjumX6MuE8YVs0=;
 b=mDps+7OsOiKl7vjB0ljRfaYPEurVTCitDYJbmYETEH8zm7Y/gtLycr/M4HI7yQWKxpODcqKARzeEb6eFTmIqiSv3uuggMxwtZpZ95p4pYc0Kk9UPeQ4H0JWPPyVQXOltmSrgwVH63cpjxnoEjdVt9YKOS4MxMPOWCzJbyUrQ+COhDPYle2vnK6JJrSgVLeEp+LubSmH6vzuuOhrf6YAKi/lQ7W8zt/POpZ+wsBlGD1eLEfqA0zBOb7VjpnQX3IRePKV3oQTtJPo8Bp68788D4o9wLDkfzAM0ZW9UxX9SchtBXJjmtYhWOEA3hj9ev6Yz7k3bnSvgTwJFSD6nxpCyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ug3kGSFbTnjlHjs5EQ22zfgErmlaCzjumX6MuE8YVs0=;
 b=ExfuRA4KnNKJRk18kWe02if8VrvH+mpQhDv52vHrtsuz6A6rPd0wmFiBjdTyCnkHaxQoSKq0QICqfbUU3XxBmh1qiV9kSQ0ei5XRXTmLuU2aIT3QwYUlAkcg9c6uzuaf0LFLGgx4Q97qsHnnMZqCAH12Wo+ZQn4tnBRnQyBKdEI=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by IA0PR21MB4005.namprd21.prod.outlook.com (2603:10b6:208:491::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6723.4; Tue, 15 Aug
 2023 18:44:43 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::ed39:f9ac:9110:dd9a%4]) with mapi id 15.20.6699.012; Tue, 15 Aug 2023
 18:44:43 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "levymitchell0@gmail.com" <levymitchell0@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [PATCH RFC 0/2] hyperv: Use raw_spinlock_t when not sleepable
Thread-Topic: [PATCH RFC 0/2] hyperv: Use raw_spinlock_t when not sleepable
Thread-Index: AQHZyxH82YnSmUMrSEOFeQE4DDrDoa/rtthw
Date:   Tue, 15 Aug 2023 18:44:43 +0000
Message-ID: <BYAPR21MB1688E555A717F1CD01040A07D714A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230809-b4-rt_preempt-fix-v1-0-7283bbdc8b14@gmail.com>
In-Reply-To: <20230809-b4-rt_preempt-fix-v1-0-7283bbdc8b14@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3fefc4d5-b2b5-458f-93ba-a2e9c3004daf;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-15T18:29:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|IA0PR21MB4005:EE_
x-ms-office365-filtering-correlation-id: 950b4b2d-7553-47f4-d506-08db9dbfb0be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nbpOI5sMJnKsECvkJWlzb2VH6jwNEykjeek9fHZxvs4TxYyzOUB2P1LAoHGHyAnt0i+MCHqJ67bSNbEmOOBXPRXfjdp4NHwnzxPT14vTQsiUWfw6MfGSSKUbufK086hEjv65urEOJUuXsZjEZ+TMUGl/MBbNs51IU9XCrYLd4UNUfDcQYjmP4w7a31oH+Ut/Pf/fRULi/4D+NA2e6LhoLC/W98FdEB4JUtUEwLUBH1tXf4peKVCE5dj56gxL26HRWuCYdRNZhThs1yC5TuaN6FG8e6Qfu+z17rm0clIYss7F01M+0ILQI1t+/8LNL9CV5KOSKM6IsEMCD/i1lmqlPIKbqO8mlbtRGumSYfTjIscndTW6WCbkixw91DIxV2dJ4gnxttiA1Bdo++AZ4YJSOlyQXoK55RpTYMOJ2IcxHlpAKgtHPDHb0WME5rMPbOfDzQJHQvjLU1fDqdJIuxtB2ZArsFh3kASEGFIwzQFpMzJZ8VMGYlDwY7Dbqgh1ez9iVmgv0guhOLbyFAL6xfOqWVY+qyDcT6Rdq89EsuV69dt7D1rAemfCjZMhy2YpKYVfimo550JM0yVifr9vDnDeIfXdisG0X8UnZwLlrUgBaWXTOFv/MxcFtoXJKE3iDHfr/JOJVlj8lgIcak0d9Yw/j0CDY+wj0zr31MMQXVBPJbNTfqO3yv30eWVV+PXIDFSFsA9ggkz0iw/hlegXBi/kqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(1800799009)(186009)(451199024)(4326008)(54906003)(6506007)(110136005)(76116006)(26005)(10290500003)(7696005)(478600001)(12101799019)(66899024)(122000001)(2906002)(9686003)(8990500004)(55016003)(66946007)(8676002)(66446008)(41300700001)(8936002)(64756008)(52536014)(316002)(66476007)(5660300002)(82960400001)(38100700002)(82950400001)(86362001)(33656002)(38070700005)(71200400001)(83380400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2FVZC9nZjBCKytPVkN1V1JnbFpCRFpvcmdCZUFuU0FLR25NNEdMcDh6c1lB?=
 =?utf-8?B?NU5IaFhvdEZUN2RTL0w2ck1INnVyN1NNaVZLQVROQTVKcnM2enpNVlZqREMv?=
 =?utf-8?B?SUo4SFlxYytDRWNENzlManRVOGhUbzR2eStua0gydEVQZGsydWFkalY1TFVQ?=
 =?utf-8?B?OUJwdVZPNTRST2tqTnNhN3VHTXQ3S0RMdWNVTHYxaW1TeGpqTHNjZkRQNkpL?=
 =?utf-8?B?eENpUFpZUENjenNXWG1XbnVVR3REd0dIWkZDL0xHZm9uY1A3VzJtTlA3NXZr?=
 =?utf-8?B?cGtoNHBNcEpIcW02dkFnbHdyQ3pIeDVNSzQvVm8zTEE2dFhiYndqeVBRQWkr?=
 =?utf-8?B?MWJYSGJJdW1NTzhVd3p0Z3F2NlA4ek0zd2Z0VXJDNkFzcDJzZ1lpVlN4Q2cr?=
 =?utf-8?B?QTB2S0p5ZHdIMjJmTTVRVkJJTHBueDRBOXFYQ1ZiWkM3T1lxOXltMmlxSkhN?=
 =?utf-8?B?MytWR2szdWRZYjNkSnRkMFR5N3lveVM3NGFYWE1EU1RIaVJQWEZ5VytmelB6?=
 =?utf-8?B?QnlUcjRkVEQ5anptUmEzNEtDRXdOWFppUTlLTnBjcUlsc3B6NEtZSkp5NXc0?=
 =?utf-8?B?WUtxMHNzZGthM0ZVbk9IbUFpTGxmZXMxNFhyTlU3Mm9FdGdRc0ZpTkZiajRz?=
 =?utf-8?B?QktXWTJYaWFCemRVbThKM0pYSjRxZTBxRFdPRmNkL2ZHSFdnUFhkbEsrN3o3?=
 =?utf-8?B?V3pvWkhIOFMyeE8zd3JqdHhDcFBaMDAxN3hPMlBZOEpGWG1KblB4QjhCZnFJ?=
 =?utf-8?B?VTlDdUxiQXlkc1dvM3dpMlZuaG5taExQa2RSNlFBdlBBQ1VXOTdSTEZGeEZK?=
 =?utf-8?B?bFZxNzVxZDJ0NS9Ncm9HRlF4aEdYTjVBWjAvVTRJSUkvQWRSV29YbzMxSXcw?=
 =?utf-8?B?ZldBeWhMVDA0N3BKNTNjSmJkU0EzZVUwUVJXb3Ewa1Jhd2RicFk4TlljU3Rn?=
 =?utf-8?B?YlczQ21janVTc25nMU5EcEYycW9XWEpJcVd4UThTZkt3MngrZUV3NUsxZHJL?=
 =?utf-8?B?U2FVdTB4dnBNckJoelQ3S3duVnIyd1BJNHdweEdpU3AzRHM1UEVmbWw0Z1BN?=
 =?utf-8?B?YWt1ZkM4N1p4a0ZGNmZIenliRlVVN2srMExaV2c5WSsvTnM3OC9icTl1cVhl?=
 =?utf-8?B?MVUwei9EMWVYeDdxSVpJWFZBZEZBdjlGVFpRUFNnbUMxdlRaSmdKYmhOdnNI?=
 =?utf-8?B?ZGJ6WjdnalhRN3pPTjFxSTh2SXBIWDAzWkU2bDAvajkybWlRLzgwZ29ZM2tz?=
 =?utf-8?B?emJ2NkVaUDNwNlB1Z25PdGJ6RTg0ZithTlM0Rms5QWhtRlN5eXFKbG05VFcz?=
 =?utf-8?B?aXNMcXNqaVRSbFdZdGJLcVRSZWZXeEgxZmYwNFhTbXBUcjl5WGNyYnF1Umsw?=
 =?utf-8?B?RVArOCs3Z251VnJySjFCcEVjMlo5eHNodUZ6VFczTG1FOFIwcjhyTXY5aHdq?=
 =?utf-8?B?djQzMUZxaVVyVCs5eXdmVkovMHNNS0JzWWlVV29rcmlTYUNMWVdDalVuZEkx?=
 =?utf-8?B?L1lWUnlLZ0w2S1M1cDV6VnFITUlVb3pveFhDczVvWnBnVWE4ZzNieGU5WnU2?=
 =?utf-8?B?M253eXpNNEFydlZ4akRpZ1RyVU9jZWxWUUlocnhtc013bk9PV2dUR2o1RThF?=
 =?utf-8?B?U1FGM040WW9CMUVZRlhGK21RZFo0N05KUDQ2dVU4MWZrNDZTSDZYbEQvUysz?=
 =?utf-8?B?QWdWVk5tb281U2RDVDJ6RW9aaVlQb0RLamREZDlwTlQyNDFxajVsU3lYSzh5?=
 =?utf-8?B?RmxJa1NrZnBlYlUwMTFVdERDRnRPOGxvakM3YnV4clNSMjFiWTVEeVd6Y3N2?=
 =?utf-8?B?WUNJWEp2ZUZ3a1JjNXUvbEIvT2hHUCsxUDJwY1VHTjhZLzZFc1k3STQyaTFq?=
 =?utf-8?B?eDBWcHJ6cG1wRndmRlNYMkx0MDZuV1ZzRHBCMExzb09yeGFlUjkxSm5mNkNK?=
 =?utf-8?B?UTM4Ym5hVkt2a1MweVpOUG9xeGFxenlDOEp4bXBoaFB5VnNCZE1IN0hBVGdN?=
 =?utf-8?B?UXhZa2hGTGVUZEx4TTEvOGhXT3J0b2lEd0w1SmVVNnEwQmdZR3hzNElRaHhS?=
 =?utf-8?B?SnlQSE5xa0svdmN4a1UwY25jdkhjYkFmM2x1dndsMTkyQ0VJQVY1SlpMeWxr?=
 =?utf-8?B?MFVvMlJlVWpCbWs1MWZXUVVRd2ZCL2tveEdCeVZ0R255RUtxR1NKS0QyMFcy?=
 =?utf-8?B?QWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 950b4b2d-7553-47f4-d506-08db9dbfb0be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2023 18:44:43.2574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aDAFYB1C/jm1KkjThjuD0572TburF7bK4RJDWXpE/Bu7/W6h9lwjXX5HlSKZuuG+zXm77j3uUPISjd5uW770rDg9TLCIcbOXa9w8BAXGiyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR21MB4005
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogTWl0Y2hlbGwgTGV2eSB2aWEgQjQgUmVsYXkgPGRldm51bGwrbGV2eW1pdGNoZWxsMC5n
bWFpbC5jb21Aa2VybmVsLm9yZz4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgOSwgMjAyMyAzOjM3
IFBNDQo+IA0KPiBXaGVuIGNvbXBpbGVkIHdpdGggUFJFRU1QVF9SVCwgc3BpbmxvY2tfdCBpcyBz
bGVlcGFibGUuIFdoaWxlIEkgZGlkIG5vdA0KPiBvYnNlcnZlIHRoaXMgY2F1c2luZyBhbnkgbG9j
a3VwcyBvbiBteSBzeXN0ZW0sIGl0IGRpZCBjYXVzZSB3YXJuaW5ncyB0bw0KPiBiZSBlbWl0dGVk
IHdoZW4gY29tcGlsZWQgd2l0aCBsb2NrIGRlYnVnZ2luZy4gVGhpcyBzZXJpZXMgZml4ZXMgc29t
ZQ0KPiBpbnN0YW5jZXMgd2hlcmUgc3BpbmxvY2tfdCBpcyB1c2VkIGluIG5vbi1zbGVlcGFibGUg
Y29udGV4dHMsIHRob3VnaCBpdA0KPiBhbG1vc3QgY2VydGFpbmx5IGRvZXMgbm90IGZpbmQgZXZl
cnkgc3VjaCBpbnN0YW5jZS4NCj4gDQo+IEFuIGV4YW1wbGUgb2YgdGhlIHdhcm5pbmcgcmFpc2Vk
IGJ5IGxvY2tkZXA6DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IFtCVUc6IElu
dmFsaWQgd2FpdCBjb250ZXh0IF0NCj4gNi41LjAtcmMxKyAjMTYgTm90IHRhaW50ZWQNCj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gc3dhcHBlci8wLzEgaXMgdHJ5aW5nIHRvIGxv
Y2s6DQo+IGZmZmZhMDVhMDE0ZDY0YzAgKCZjaGFubmVs4oaSc2NoZWRfbG9jaykgey4uLn0tezM6
M30sIGF0OiB2bWJ1c19pc3IrMHgxNzkvMHgzMjANCj4gb3RoZXIgaW5mbyB0aGF0IG1pZ2h0IGhl
bHAgdXMgZGVidWcgdGhpczoNCj4gY29udGV4dC17MjoyfQ0KPiAyIGxvY2tzIGhlbGQgYnkgc3dh
cHBlci8wLzE6DQo+ICAjMDogZmZmZmZmZmY5MDlhOWM3MCAobWlzY19tdHgpeysuKy59LXs0OjR9
LCBhdDogbWlzY19yZWdpc3RlcisweDM0LzB4MTgwDQo+ICAjMTogZmZmZmZmZmY5MDc5YjRjOCAo
cmN1X3JlYWRfbG9jaykgey4uLn0tezE6M30sIGF0OiByY3VfbG9ja19hY3F1aXJlKzB4MC8weDQw
DQo+IHN0YWNrIGJhY2t0cmFjZToNCj4gQ1BVOiAwIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90
IHRhaW50ZWQgNi41LjAtcmMxKyAjMTYNCj4gSGFyZHdhcmUgbmFtZTogTWljcm9zb2Z0IENvcnBv
cmF0aW9uIFZpcnR1YWwgTWFjaGluZS9WaXJ0dWFsIE1hY2hpbmUsIEJJT1MgSHlwZXItVg0KPiBV
RUZJIFJlbGVhc2UgdjQuMSAwNS8wOS8yMDIyDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaXRjaGVs
bCBMZXZ5IDxsZXZ5bWl0Y2hlbGwwQGdtYWlsLmNvbT4NCg0KR2V0dGluZyB0aGUgSHlwZXItViBz
cGVjaWZpYyBMaW51eCBndWVzdCBjb2RlIGJlaW5nIGFibGUgdG8gd29yayBjb3JyZWN0bHkNCndp
dGggUFJFRU1QVF9SVCBpcyBhbiBpbnRlcmVzdGluZyByZXF1aXJlbWVudCB0aGF0IHdlIG9idmlv
dXNseSBoYXZlbid0DQpkZWFsdCB3aXRoIHlldC4gIFVuZm9ydHVuYXRlbHksIGNvbnZlcnRpbmcg
dGhlIGNoYW5uZWwtPnNjaGVkX2xvY2sgdG8NCmEgcmF3IHNwaW4gbG9jayBkb2Vzbid0IGZ1bGx5
IHNvbHZlIHRoZSBwcm9ibGVtLiAgT25jZSB0aGF0IGNvbnZlcnNpb24gaXMNCmRvbmUsIHRoZXJl
IGFyZSBtdWx0aXBsZSBwbGFjZXMgd2hlcmUga21hbGxvYygpIG9yIGEgcmVsYXRpdmUgY291bGQg
YmUNCmNhbGxlZCB3aXRoIEdGUF9BVE9NSUMgd2hpbGUgaG9sZGluZyB0aGUgc2NoZWRfbG9jay4g
IFdoaWxlIHN1Y2gNCmFsbG9jYXRpb25zIGFyZSBhbGxvd2VkIGluIGEgbm9ybWFsIGtlcm5lbCwg
dGhleSBhcmUgbm90IGFsbG93ZWQgaW4gYSANClBSRUVNUFRfUlQga2VybmVsLg0KDQpPbmUgc3Vj
aCBwbGFjZSBpcyBpbiBodl9jb21wb3NlX21zaV9tc2coKSwgd2hlcmUNCmh2X3BjaV9vbmNoYW5u
ZWxjYWxsYmFjaygpIGlzIGludm9rZWQgd2hpbGUgaG9sZGluZyB0aGUgc2NoZWRfbG9jay4NCmh2
X3BjaV9vbmNoYW5uZWxjYWxsYmFjaygpIGRvZXMgbWVtb3J5IGFsbG9jYXRpb25zLg0KDQpBbm90
aGVyIHBsYWNlIGlzIGluIHZtYnVzX2NoYW5fc2NoZWQoKSB3aGVyZSB0aGUgb25jaGFubmVsX2Nh
bGxiYWNrDQpmdW5jdGlvbiBpcyBkaXJlY3RseSBpbnZva2VkIHdoaWxlIGhvbGRpbmcgdGhlIGxv
Y2sgaWYgSFZfQ0FMTF9JU1IgaXMgc2V0Lg0KSFZfQ0FMTF9JU1IgaXMgc2V0IGZvciB0aGUgdWlv
X2h2X2dlbmVyaWMuYyBkcml2ZXIsIGFuZCBmb3IgdGhlIG5ldHZzYyBkcml2ZXIuDQpJIGRpZG4n
dCBmb2xsb3cgYWxsIHRoZSBjb2RlIHBhdGhzIGluIHRoZSBuZXR2c2MgZHJpdmVyLCBidXQgSSBz
dXNwZWN0IHRoZXJlDQphcmUgcGxhY2VzIHdoZXJlIHRoZSBuZXR2c2MgZHJpdmVyIGNhbGxiYWNr
IGZ1bmN0aW9uIGRvZXMgbWVtb3J5IA0KYWxsb2NhdGlvbnMuICBJIGRpZCBsb29rIGF0IHRoZSBo
dl91aW9fZ2VuZXJpYy5jIGRyaXZlciwgYW5kIEknbSBwcmV0dHkNCnN1cmUgYSBtZW1vcnkgYWxs
b2NhdGlvbiBjb3VsZCBiZSBkb25lIGJ5IHVpb19ldmVudF9ub3RpZnkoKSB3aGVuDQpzZW5kaW5n
IGEgc2lnbmFsIHRvIHRoZSB1c2VyIHNwYWNlIHByb2Nlc3MuDQoNClVuZm9ydHVuYXRlbHksIG5v
bmUgb2YgdGhlc2UgcGxhY2VzIGhhdmUgZWFzeSBmaXhlcyBmb3IgdGhlIG1lbW9yeQ0KYWxsb2Nh
dGlvbiByZXF1aXJlbWVudC4gIEdldHRpbmcgdGhlIEh5cGVyLVYgc3BlY2lmaWMgY29kZSB0byB3
b3JrDQp3aXRoIFBSRUVNUFRfUlQgd2lsbCBsaWtlbHkgcmVxdWlyZSBzb21lIG5vbi10cml2aWFs
IHJlZGVzaWduLg0KDQpHaXZlbiB0aGVzZSBsaW1pdGF0aW9ucywgSSdtIG5vdCBzdXJlIGlmIG1h
a2luZyB0aGlzIGNoYW5nZSBpcw0Kd29ydGh3aGlsZS4gICBJJ20gbm90IDEwMCUgY2xlYXIgb24g
eW91ciBnb2Fscy4gIElmIGl0IGlzIHNpbXBseSB0bw0KZWxpbWluYXRlIHRoZSBsb2NrZGVwIHdh
cm5pbmdzLCB0aGVuIHBlcmhhcHMgdGhlcmUncyBhbg0KYXJndW1lbnQgdG8gYmUgbWFkZSBpbiBm
YXZvciBvZiB0aGUgY2hhbmdlcy4gIEknbSBvcGVuIHRvDQpmdXJ0aGVyIGRpc2N1c3Npb24gb24g
dGhlIHRvcGljLg0KDQpNaWNoYWVsDQoNCj4gLS0tDQo+IE1pdGNoZWxsIExldnkgKDIpOg0KPiAg
ICAgICBVc2UgcmF3X3NwaW5sb2NrX3QgZm9yIHZtYnVzX2NoYW5uZWwuc2NoZWRfbG9jaw0KPiAg
ICAgICBVc2UgcmF3X3NwaW5sb2NrX3QgaW4gdm1idXNfcmVxdWVzdG9yDQo+IA0KPiAgZHJpdmVy
cy9odi9jaGFubmVsLmMgICAgICAgICAgICAgICAgfCA2ICsrKy0tLQ0KPiAgZHJpdmVycy9odi9j
aGFubmVsX21nbXQuYyAgICAgICAgICAgfCAyICstDQo+ICBkcml2ZXJzL2h2L3ZtYnVzX2Rydi5j
ICAgICAgICAgICAgICB8IDQgKystLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ktaHlw
ZXJ2LmMgfCA2ICsrKy0tLQ0KPiAgaW5jbHVkZS9saW51eC9oeXBlcnYuaCAgICAgICAgICAgICAg
fCA4ICsrKystLS0tDQo+ICA1IGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEzIGRl
bGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IDE0Zjk2NDNkYzkwYWRlYTA3NGEwZmZi
N2ExN2QzMzdlYWZjNmE1Y2MNCj4gY2hhbmdlLWlkOiAyMDIzMDgwNy1iNC1ydF9wcmVlbXB0LWZp
eC0zNWE2NWM5MGM2YzkNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gTWl0Y2hlbGwgTGV2
eSA8bGV2eW1pdGNoZWxsMEBnbWFpbC5jb20+DQoNCg==
