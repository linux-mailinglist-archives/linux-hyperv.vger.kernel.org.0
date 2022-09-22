Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBD35E6EF2
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Sep 2022 23:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiIVV7Z (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 17:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiIVV7Y (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 17:59:24 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastus2azon11021026.outbound.protection.outlook.com [52.101.57.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1683A10AB00;
        Thu, 22 Sep 2022 14:59:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PN+PEgSI0KZDRYIHf4QWY2Vj8WrTCylTfN4+g3mQN+pywql6SJJv/LxDwz6L7Bw49OxhjPVR5sdOGu22qldHEA/drfxE5DcYSawIxjai7v2Jj4FcZkPVstbNt5131vjF4FjwrNS64/xXX1n2ZDZV+O8X5+aNMW7koflWntNdRZRe2uc8TKs9HU3NsiEP8OiGwLfvWtnJraHo6Mw0A6lm609aRs3q4q586DkSvnbKvIsA5HHN0gqlJ8tSfa7QJ+R2mMhCTouwE86z4Gw/fhAU5O4srZU9lnC429ivke/7xNx8nLQ2duoT1jLpVl4H2XTgkSbOlo3UwCZIn7+p91Nb9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ABymXy5NjCNTAp2uYSoxOjfZJ2j6f0d6nIJxHx9Mqc=;
 b=MXJoIg8NdR2wY1d6e/W4rRYXTfL9CYiWYAxrHV4yUjO58Dmhm64IO+GKoNCggzSQHFAds7wwtpzwORHznRFrbHX+puJMZg61RnXV7pYNswBnIGvCKfoZuU5BluNyVCJPVic0nlgoNh3xpnLB8Cyg7i7/yN1pmLEumfQFKtS78Tu0ZpLMrCuIrNzjOAna4UIqHoY3okdx9XpZih4ScN4jFiGl7zx/AV43B94stqjGnKl5T4AgjyRpTwJJNUKzX6fjSM4pVLp9EX7etpQx4hWv9l61eiIU1nwETm5VWZlKLB4vexwHqv/D+3OsOi1nEoNDMDMRb3E+EsqsYy7RbqOajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ABymXy5NjCNTAp2uYSoxOjfZJ2j6f0d6nIJxHx9Mqc=;
 b=K4LtwuF/3iWzFkWy0B2qHHnrg4kWxg8cRXRTFf8zDVH862v9J5JCt1XBiCd9Ms+88heCJNVJ7USTd8WMJscHl3Vormi6Or3mS/Rb/Iqdqzn5LIBzf8CYCLelE1/ZBkwbA+M7F851cJ3zAnAjYxeTkBEPXks6s+jL/vkMeSe2cI8=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SJ0PR21MB1952.namprd21.prod.outlook.com (2603:10b6:a03:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Thu, 22 Sep
 2022 21:59:19 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5676.007; Thu, 22 Sep 2022
 21:59:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
        Stanislav Kinsburskii <skinsburskii@microsoft.com>
CC:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Don't wait for the ACPI device upon
 initialization
Thread-Topic: [PATCH] Drivers: hv: vmbus: Don't wait for the ACPI device upon
 initialization
Thread-Index: AQHYzelxktwUHXD67UeE5fPb/vdszq3r/Qlw
Date:   Thu, 22 Sep 2022 21:59:19 +0000
Message-ID: <BYAPR21MB1688B7F27A590104D6E3426ED74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <166378554568.581670.1124852716698789244.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: <166378554568.581670.1124852716698789244.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d0aa1aef-de20-4ed0-9ba4-1af3005f8636;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-22T21:44:02Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SJ0PR21MB1952:EE_
x-ms-office365-filtering-correlation-id: 88682942-5de6-4334-c5ca-08da9ce5b33c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uc+yMPesaFsJ1DINjwg6uA6H5atsdskRX1TmJpZze8rJt+0W3L7UCjpOsd3WB93rQhUbl7SBfZwpVPQDOzgl0cRJZLLL5lh3ATZLtY31il8cnFzL18RXA4VhmSqlDWx4VXV1zHUDTW782px93E/sVhTP+q3oGvCjIakkEw6fpKNekCQ68IysU1diYA974+SnjieQiky1DABZcwI9TzeVNZNECJILSrf/OglLDcxVguTbh60fkoLyDGDhibAK3AnwuastI+YpYz5dNQKP2ZRLhb+EELoApaFR3u+wZp51B5hFyGdZwhExxTwJUn3cA0KthDXMRWWG0prC/IhSEi1U1OVNdxS+y2MKmLxI08gShEIRMPkc1NCwiQRU5TyB9wMeLrx7MoHsQhg5dBhqpv+d4hU8PYBRXmQIw0xJari4LS83sNVb7qKfx8rcKvh7WApWiVhlfp8mFB//1TeWCPq7VnB74Fzwo2F9V+JzO/Axuukv3ekQ9fK1O9lkiKHcBjfUPFnVeBtWxRNz5lcHxrjyWKFC4m+kGiPBxzHbxN4tE/Rso0qCiWun0YZ2X/K7LzFxqgcevFilzehz0e82r8us/JgEsVmy7bCzalVrjbPaXVM/e+pkOC48eucA2TqDUALQiAHWVizOiZVOkWmzQSB7RhtGcsEYUByZ9/WgF0iZtynihEnyuI2nuAfDqepaENQF7263+GcKqtSynJCy4BbgM3jlx8FhEOMY241lxkMocJ9S/no3gacEPVlYMEs+dQOycIGRY36V3UrHSllQ/Il1dp+yjgf4/6mAX2wlblAnlbPd9pK5rY/CzsWRO6mGxphz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(451199015)(26005)(316002)(9686003)(6636002)(33656002)(478600001)(6506007)(10290500003)(54906003)(110136005)(71200400001)(122000001)(38100700002)(7696005)(38070700005)(82950400001)(82960400001)(83380400001)(186003)(55016003)(76116006)(86362001)(8990500004)(2906002)(4326008)(66446008)(8936002)(5660300002)(52536014)(8676002)(64756008)(41300700001)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TEhZU1p6WHZ5NDRFWEZpbUVPeFJ6a0pxb2N2V1U5YklsL0pFUUdzWHJMQUpW?=
 =?utf-8?B?Rk5rSFo0THlHbnZUWTlwSTgwdEloYnBqOFFVNDhyR0xCMWlCUW1NMnBEWktZ?=
 =?utf-8?B?dzMwMEgzVGN1b3VPLy84RU84SjUxVUx1MU9NZXVRTGRHUzZRMGpYYzhHUll3?=
 =?utf-8?B?cVlQUnZYRzB3dkNmcnZSbTJ3N0pobjRyU3NpaXF5NVZtdk1ON05oV1QyWVhH?=
 =?utf-8?B?bmRBazQ2S1pCdVMvblUzZUkzS2dTYjVRUys0ek16QXMzNzdzc25WZVI1R0Ji?=
 =?utf-8?B?N0VIT2NBaThORzc3R3Rsczh1QXpLcTdBTCtuNVJzNE1aaUgwcDBFNVdrVmRJ?=
 =?utf-8?B?SnNuc3lXMGUzVVFxdGo3UDVvWjdlT2VCQVZoemxGS1ZCZk9lWGVUZ0U2b2Rk?=
 =?utf-8?B?U3RYK01oQUZBaGpPaUhkOE90WTJ4eXdHUUJESWZwKzRRem1VcHptZ3dSZnRu?=
 =?utf-8?B?V2xkaHAzU0pxaGJaV0FZcThPaVVwa3FremZObWhseVZzU3hKWnUweGh4ME9P?=
 =?utf-8?B?K3Ixb3lyRkUvMDJCTzcycWJtOEMwd2JuQmxiWDNaYW1pNnRCRmx2Y2NldW9k?=
 =?utf-8?B?cXp1QndXQ0tLWVVoQmdHUjJFbXUyZi82VTMzbHZDb1MxeDNBdzBPUUNCVGQ2?=
 =?utf-8?B?Ym14bVBiTEZtQXpYN1JVTGU2WmlTemtsUnRSVlRXcHlPekoraHUwT0pkdFc3?=
 =?utf-8?B?Z3NGbUc3aUtuNGJ3ZDlRZTVXVjBYMFRyY2RlR01sakFnRGRZTW9sRzluN3c5?=
 =?utf-8?B?TEtlMys3Rnp3WHdJbkdwbGk2L0dDWnlCNUhuck12VmM1RW9UWThGV2NNVkZk?=
 =?utf-8?B?czl1dDdMWTJ6SGpCZEJyU2pOYVRsS1BaZDhULzlweS90eUhIbll4bk90Z2c2?=
 =?utf-8?B?ZHlxSEI2b1FtbHRBS2c4a3BiVXlVRzN5K1o3akFRWk0wYVJyRmVBZU1sWndm?=
 =?utf-8?B?dkN5dS9TNjBHMGtITWJHNm9ZcWZaZVhiSEF2ajFrT0czbHJzdDlRNERpbFJs?=
 =?utf-8?B?MU9tOFVwTU1kYUVqRThWM0xtZW4ycUZOcWxhRDY4M2JISjl0Sm1VdjduU0VV?=
 =?utf-8?B?Wnl3bG5qTUhHMHpDaDNnYjMzMnIrSVd5bGMxNHhKcUN6b1QySVB0amxyRWJJ?=
 =?utf-8?B?dVpRMmVwdy9oRTlxcVJjaTU3YkY4NURzTktUQ2NJeFBTenpLdUFGcGNxZkZl?=
 =?utf-8?B?a292TGNmdXdJK01FKzdxSWZKMUU3czhHV0xDUTBaa1Y0Z2g5UlZuanRESmVF?=
 =?utf-8?B?dk5uUU9pY3BQSWxiY3hIcll3SW5veDNCS1V6bFBBQ3daeHkrQU50ZzdoWERS?=
 =?utf-8?B?NDUwWXVBWTVyTXdjcGVHWXZYL3NrMFU3MWNsL1hBMEFaODZiTXBpRm1Qc0pj?=
 =?utf-8?B?aFBvUFJiU0tQM3dLeGFEL0JJVW1DRFBCVkY3QTdYZ21ISW5DUTI5aCtDZU9W?=
 =?utf-8?B?QU5MeXdkQVkxaVVEMEl3Z0QxUkJ2d3d6NEpONVFGZ0x3WEU0ckhDVklOcm1F?=
 =?utf-8?B?U3RNU2o3aDR6Z1JxOHpqQzR3d0pLTFFjdjg5bFgwQTgxZXFxb0djSTVSVTJF?=
 =?utf-8?B?UXM4blYwemtHUUNWVUpvMFhGWnRzL0J1UjMwOXczVzRHR0NURVVsWndCMElj?=
 =?utf-8?B?RVM3dlZaVGd2KzJuOHJEaXdWWVo1V0pwV2xpOXpEc3ptUGNoMk5vVXN1a3Vq?=
 =?utf-8?B?SkxCNEIxMEg5a1ZBSmRzdHQ5WlFLRFBEQ0NMbkhKOHpwMUdlQVdRRERSNEwx?=
 =?utf-8?B?cWYreExVaGN5dGszaHR3d3BXWU1HZm9mTUg1a0RhSlRLbTRnQ0pDWEZWbkU2?=
 =?utf-8?B?RThXMDVuSHFWc05lQ3VGeFhCMTZuMUlKRUdSay9LNEZIMTl4Q0hxWE83blhX?=
 =?utf-8?B?Q1ZZT2lwWnJXZmZxc09VSkM1VlVGaElTZFF5Ty9nMjFYMzNHTUtzNUE4allV?=
 =?utf-8?B?Y1dkWWVLZ0orcnB1Q3pweGd2bGduTWxncnJ3Z0YveERjU2UwRHBYVGVSQ2Rk?=
 =?utf-8?B?YkFJRWRPVnhvWVdqcnNLenMwLzdyMStRUERlWEF5S2FJUEtlSSs1UFF4SUgy?=
 =?utf-8?B?V1EzYlRCdGx1TFNGTnkwV0V1amcvUGVScTFYUnNUbmI5U0dubGx0MkdMZURZ?=
 =?utf-8?B?TmVmRGhrNnVkcmlZTWpGdmtBOTRCVXQxZTd2SVgxOWp2UVhnVEtSdE5mUFZt?=
 =?utf-8?B?MWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88682942-5de6-4334-c5ca-08da9ce5b33c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 21:59:19.4738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VlYfYPhgqUDdcbkQ1vghv/s9GIvWe1+JO7sHNpJX98J27ZNvRDmw4VcL1qt4OeA8jDWKAXixOOLCE9laaXMzaejmHUfIt4B7EZYq3AoyMP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1952
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

RnJvbTogU3RhbmlzbGF2IEtpbnNidXJza2lpIDxza2luc2J1cnNraWlAbGludXgubWljcm9zb2Z0
LmNvbT4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjIgMTE6MzkgQU0NCj4gDQo+
IFdhaXRpbmcgdG8gNSBzZWNvbmRzIGluIGNhc2Ugb2YgbWlzc2luZyBWTUJVUyBBQ1BJIGRldmlj
ZSBpcyByZWR1bmRhbnQgYXMgdGhlDQoNCkEgbml0OiAgV2UndmUgYmVlbiBhbGwgb3ZlciB0aGUg
bWFwIG9uIHRoZSBjYXBpdGFsaXphdGlvbiBvZiAiVk1CdXMiLiAgU29tZWJvZHkNCm91dHNpZGUg
b2YgTWljcm9zb2Z0IHJlY2VudGx5IGRpZCBhIGNlbnN1cyBpbiB0aGUgTGludXggY29kZSBhbmQg
Y29tbWl0cywgYW5kDQoiVk1idXMiIGlzIHRoZSBtb3N0IHBvcHVsYXIsIGNsb3NlbHkgZm9sbG93
ZWQgYnkgIlZNQnVzIi4gIFRoZSBwcmVmZXJyZWQgYXBwcm9hY2gNCmluIE1pY3Jvc29mdCBwdWJs
aWMgZG9jdW1lbnRhdGlvbiBpcyAiVk1CdXMiLCBzbyB0aGF0J3Mgd2hhdCB3ZSBzaG91bGQgdHJ5
IHRvIA0KdXNlIGdvaW5nIGZvcndhcmQuICBOb3QgIlZNQlVTIiBhbmQgbm90ICJ2bWJ1cyIsIHRo
b3VnaCB0aGUgbGF0dGVyIGlzIGZpbmUgaW4NCnZhcmlhYmxlIGFuZCBmdW5jdGlvbiBuYW1lcy4N
Cg0KPiBkZXZpY2UgaXMgZWl0aGVyIHByZXNlbnQgYWxyZWFkeSBvciB3b24ndCBiZSBhdmFpbGFi
bGUgYXQgYWxsLg0KPiBUaGlzIHBhdGNoIGVuZm9yY2VzIHN5bmNocm9ub3VzIHByb2JpbmcgdG8g
bWFrZSBzdXJlIHRoZSBidXMgdHJhdmVyc2FsLA0KPiBoYXBwZW5pbmcgdXBvbiBkcml2ZXIgcmVn
aXN0ZXJpbmcgd2lsbCBlaXRoZXIgZmluZCB0aGUgZGV2aWNlIChpZiBwcmVzZW50KSBvcg0KPiBu
b3Qgc3BlbmQgYW55IGFkZGl0aW9uYWwgdGltZSBpZiBkZXZpY2UgaXMgYWJzZW50Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogU3RhbmlzbGF2IEtpbnNidXJza2l5IDxzdGFuaXNsYXYua2luc2J1cnNr
aXlAZ21haWwuY29tPg0KPiBDQzogIksuIFkuIFNyaW5pdmFzYW4iIDxreXNAbWljcm9zb2Z0LmNv
bT4NCj4gQ0M6IEhhaXlhbmcgWmhhbmcgPGhhaXlhbmd6QG1pY3Jvc29mdC5jb20+DQo+IENDOiBT
dGVwaGVuIEhlbW1pbmdlciA8c3RoZW1taW5AbWljcm9zb2Z0LmNvbT4NCj4gQ0M6IFdlaSBMaXUg
PHdlaS5saXVAa2VybmVsLm9yZz4NCj4gQ0M6IERleHVhbiBDdWkgPGRlY3VpQG1pY3Jvc29mdC5j
b20+DQo+IENDOiBsaW51eC1oeXBlcnZAdmdlci5rZXJuZWwub3JnDQo+IENDOiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IC0tLQ0KPiAgZHJpdmVycy9odi92bWJ1c19kcnYuYyB8ICAg
MTMgKysrKy0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOSBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h2L3ZtYnVzX2Rydi5jIGIv
ZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiBpbmRleCA3YjlmM2ZjM2FkZjcuLjMyZDAwMDk2MzFh
NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9odi92bWJ1c19kcnYuYw0KPiArKysgYi9kcml2ZXJz
L2h2L3ZtYnVzX2Rydi5jDQo+IEBAIC00Niw4ICs0Niw2IEBAIHN0cnVjdCB2bWJ1c19keW5pZCB7
DQo+IA0KPiAgc3RhdGljIHN0cnVjdCBhY3BpX2RldmljZSAgKmh2X2FjcGlfZGV2Ow0KPiANCj4g
LXN0YXRpYyBzdHJ1Y3QgY29tcGxldGlvbiBwcm9iZV9ldmVudDsNCj4gLQ0KPiAgc3RhdGljIGlu
dCBoeXBlcnZfY3B1aHBfb25saW5lOw0KPiANCj4gIHN0YXRpYyB2b2lkICpodl9wYW5pY19wYWdl
Ow0KPiBAQCAtMjQ2OCw3ICsyNDY2LDYgQEAgc3RhdGljIGludCB2bWJ1c19hY3BpX2FkZChzdHJ1
Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkNCj4gIAlyZXRfdmFsID0gMDsNCj4gDQo+ICBhY3BpX3dh
bGtfZXJyOg0KPiAtCWNvbXBsZXRlKCZwcm9iZV9ldmVudCk7DQo+ICAJaWYgKHJldF92YWwpDQo+
ICAJCXZtYnVzX2FjcGlfcmVtb3ZlKGRldmljZSk7DQo+ICAJcmV0dXJuIHJldF92YWw7DQo+IEBA
IC0yNjQ3LDYgKzI2NDQsNyBAQCBzdGF0aWMgc3RydWN0IGFjcGlfZHJpdmVyIHZtYnVzX2FjcGlf
ZHJpdmVyID0gew0KPiAgCQkucmVtb3ZlID0gdm1idXNfYWNwaV9yZW1vdmUsDQo+ICAJfSwNCj4g
IAkuZHJ2LnBtID0gJnZtYnVzX2J1c19wbSwNCj4gKwkuZHJ2LnByb2JlX3R5cGUgPSBQUk9CRV9G
T1JDRV9TWU5DSFJPTk9VUywNCj4gIH07DQo+IA0KPiAgc3RhdGljIHZvaWQgaHZfa2V4ZWNfaGFu
ZGxlcih2b2lkKQ0KPiBAQCAtMjcxOSw3ICsyNzE3LDcgQEAgc3RhdGljIHN0cnVjdCBzeXNjb3Jl
X29wcyBodl9zeW5pY19zeXNjb3JlX29wcyA9IHsNCj4gDQo+ICBzdGF0aWMgaW50IF9faW5pdCBo
dl9hY3BpX2luaXQodm9pZCkNCj4gIHsNCj4gLQlpbnQgcmV0LCB0Ow0KPiArCWludCByZXQ7DQo+
IA0KPiAgCWlmICghaHZfaXNfaHlwZXJ2X2luaXRpYWxpemVkKCkpDQo+ICAJCXJldHVybiAtRU5P
REVWOw0KPiBAQCAtMjcyNyw4ICsyNzI1LDYgQEAgc3RhdGljIGludCBfX2luaXQgaHZfYWNwaV9p
bml0KHZvaWQpDQo+ICAJaWYgKGh2X3Jvb3RfcGFydGl0aW9uKQ0KPiAgCQlyZXR1cm4gMDsNCj4g
DQo+IC0JaW5pdF9jb21wbGV0aW9uKCZwcm9iZV9ldmVudCk7DQo+IC0NCj4gIAkvKg0KPiAgCSAq
IEdldCBBQ1BJIHJlc291cmNlcyBmaXJzdC4NCj4gIAkgKi8NCj4gQEAgLTI3MzcsOSArMjczMyw4
IEBAIHN0YXRpYyBpbnQgX19pbml0IGh2X2FjcGlfaW5pdCh2b2lkKQ0KPiAgCWlmIChyZXQpDQo+
ICAJCXJldHVybiByZXQ7DQo+IA0KPiAtCXQgPSB3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQo
JnByb2JlX2V2ZW50LCA1KkhaKTsNCj4gLQlpZiAodCA9PSAwKSB7DQo+IC0JCXJldCA9IC1FVElN
RURPVVQ7DQo+ICsJaWYgKCFodl9hY3BpX2Rldikgew0KPiArCQlyZXQgPSAtRU5PREVWOw0KPiAg
CQlnb3RvIGNsZWFudXA7DQo+ICAJfQ0KPiANCj4gDQoNClJldmlld2VkLWJ5OiBNaWNoYWVsIEtl
bGxleSA8bWlrZWxsZXlAbWljcm9zb2Z0LmNvbT4NCg0K
