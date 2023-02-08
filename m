Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A16A68F7C8
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 20:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjBHTEk (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Feb 2023 14:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbjBHTEi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Feb 2023 14:04:38 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDED53E66;
        Wed,  8 Feb 2023 11:04:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UV2r+pH6IGGboP7d6HJoMzhZna8V+hzq2rLmj6YTf1MEKx2rURcgbZSef1vNW4Pp5W+6JnK0idZXPXU4C+RcXjmoZIIEPvybM2bSepRNf9R8twThY5UyPJOlekW6DccNAOeg7ntKJuTm2kYn2DXwN7zkMFldlKMDKgYg9luZGRjEmNZmD7N7Nj1iD5ESjfymz39w4/kwjuAjKUw3M+NjvfCYq1j2+icyBUAjojYiLnU6XC2iDx2LA1I2Tm3uJlFqttne8jae2yzchSYZjP+Qe59kou2dGXh8Vq+YbDW7QTQcMRMWrLZioFrHui8PKoFT4FLABXJIcx4NXv7acHiVkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIBiaK0xRlHyRl4Q+HOcXkBZmizUWVIbys/buCrEFu8=;
 b=PfJS6Kei4PcfM7OeGdLyvUMdWmh50l7CJLVmVp3G+mHk6ArI3iPD75bwVZtB+Ql13LXA5miqtkJckzNSDyhVopMyBHkr+rbK7pPPlFkS/5FcXGbImgdY6cne/LjdkMMuwQjSAcV3dxpRo51GQhuiAuybfJ5/mZcI9bkvC+83bFlRvTiN4Ex3iWks6hCC+v0KM8fiEJQaM06WrZ/7bGqpMre3XRTS/bVFHD/VfclOzwOhjFReS51+UEQfsbw3Bmx2RKeNapuz/nZ0ORVZKK+GFxA5UGVmJcDaB25iY55k3Y1udnB/vPJHCr7sgFo8kq+N8zGRnI1+xwmi0FPLJ7GCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIBiaK0xRlHyRl4Q+HOcXkBZmizUWVIbys/buCrEFu8=;
 b=gbm5M62q6EQcl7Zgc3mqmqzDvE6KqmXBQUsuV9E9VT43e/32LtagWCi1yqEuxlWMjRYCLDUizVcry2I+VKwICxOqwPw1KhAksKj+cGMy+xSP7tUUrvDj5ogf/Cb2VsAoSRohwFIm5u/FGRDz9IK7RP9vDHNY0s7ACgL3tkK9VO8=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by PH0PR21MB1910.namprd21.prod.outlook.com (2603:10b6:510:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.2; Wed, 8 Feb
 2023 19:02:59 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::1811:5122:f6d2:35b9]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::1811:5122:f6d2:35b9%2]) with mapi id 15.20.6111.003; Wed, 8 Feb 2023
 19:02:59 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Mohammed Gamal <mgamal@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Topic: [PATCH] Drivers: vmbus: Check for channel allocation before
 looking up relids
Thread-Index: AQHZO7FcvtVZ42Ia+EWsc9sfieb8y67FZwQg
Date:   Wed, 8 Feb 2023 19:02:59 +0000
Message-ID: <SA1PR21MB1335F1074908B3E00DFA21BDBFD89@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230208113424.864881-1-mgamal@redhat.com>
In-Reply-To: <20230208113424.864881-1-mgamal@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7e5c1695-94fa-4a79-807b-eb0e851d0746;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-08T18:57:33Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|PH0PR21MB1910:EE_
x-ms-office365-filtering-correlation-id: 73adbc74-c3b6-491b-af2d-08db0a071846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ReNvuQtyA2gKs1ZAsHf8RS4lAtTfbfnCJ1txLBvAwFsJNoq/xAab50OvJqgwiyMo+8mhZUUTAZoUjJZV59iQWkB8qVzD/Owve6c9KklprmFmSGg1NzmfI7Tfl56JGw81CFiRTCbZUBAdWXkaKtebJDcr+MHXqphZeN0Ybyz8qxfGRzzmZpNfuIp+Dnvn9bY1gFyXJr+V+tQvlYnili2t0wGqiG/7QedLxjvcegy5ATRHG7HvAAhG9E8v930zOFRtI2Drq5840fDY19Iro6rNm27zOusmqaYdOG9kcjsd5RG1Vyl5BhrYRT5/i61fH9toXFzx3UQh6JPd+1i+vvtYehEH2CtP+6PIeKS+vXPAXihc+iaM7azYxmHw3FhQVPOPXwT20UqfIyCsrZH8J5xLfaMONC1jlbySSuLf9f2QsEuMFQ8+zbfbdhs7DwEEQzcjBJ0Jcye0vuuKGrED/VCxFNLVcnc921mY80qXA3qvI0ewDpEbweTlL1w7mncpXhZFZ21cZNaitkAlYwAElfYV9cdb20Gim+rsdkYqO3I6fk1oaZmb4AWAxErK66qPl76j5oeDKyaa0Ztp+uIglWEOzP4KtVZA9cGB2zXtzyXnE7lcHQqM/nnc/R2ONbrL/uA69jlUiJjbqBgnjRluPkYOaIdNXCk+PNjS7H2APzRQpR2xK7mvPM0CEOr9WUMKL/hAYsvnbK/8bTpD0yqVPQMqgpe+eC/60mP5ci75cXbZhlZEdpPqroYmDo0WWMJqBvGb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199018)(8990500004)(5660300002)(4326008)(7696005)(8676002)(76116006)(4744005)(64756008)(66446008)(71200400001)(66476007)(66556008)(110136005)(54906003)(66946007)(82950400001)(55016003)(316002)(41300700001)(82960400001)(38100700002)(86362001)(52536014)(10290500003)(122000001)(8936002)(6506007)(2906002)(478600001)(33656002)(9686003)(186003)(38070700005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/j6IgFpE5d1A81UlPTcZRugx6b+rN0jWnedfKNigtui5piLy6wTLZcCTHY5y?=
 =?us-ascii?Q?iMxhAzmr5M3FdMWwAB4SgsjHpodS53wc+bKgbwgDuV0pP1CxjwCBLDTYhWme?=
 =?us-ascii?Q?dR7p8TLTQFXB/xY/2RseF8WR5YR2nWVAC72HeUiZlAWKLx37sS2O6iuPB8cv?=
 =?us-ascii?Q?sOTVYfsZzclWZKP9j7ezFVS/nQlTfgrBi7spUjMXLFOSTxZ2t4gMie7pTSB1?=
 =?us-ascii?Q?XbD0vDeCHxkKR54EjJIT9pq+yiak4/wCHjazeiHcT4lGvB5YDCtHFaWk+v2s?=
 =?us-ascii?Q?jIhW3ov/TzqOpU8utEJYSyj/ixabDNhFe+lj7J9ENFcnX7/QUmhpI/YxhucI?=
 =?us-ascii?Q?IMIMuhTkBI1N2qOAHKBrI+nod7NTgAagrIb0LbtWtiFyfW4Mp8Bkz0z5yPDk?=
 =?us-ascii?Q?jInvRzsf+9vJ1LXyYixLG4qq7gQK3RsblPbyK5ph4t+/XDVz3zdCOCz9jfPe?=
 =?us-ascii?Q?mXV2n543wNlICONvBzloOFw7V1fbdfJAW/VsAlgPjq5kktWBoTytIvRn4nTQ?=
 =?us-ascii?Q?JAikIGDAzue9zxYbhNycSGMtstW1Dmc7KOCKMNo0DLR2N8jVzJUtPNP8O7/k?=
 =?us-ascii?Q?4gubxeLJ0HfGJRbtSOHcei6svK273gUDAM3HKyzinWWZMls5GKm7Wl4qk7Im?=
 =?us-ascii?Q?z4aNpXNZNREJEtROfPHpRoIAFjT0HAWw/cWESH9NyddKewchfJtPnyiLUiuM?=
 =?us-ascii?Q?kRbvtQeAo+H7Iu/HfKtDHZ5AGdWnSNwCbtpgygzgJxBhO8/50CC54hDcchlE?=
 =?us-ascii?Q?V7TuB0YQGCiKCY7A+c2emTYCDI447xtq/UYoS8ubcfYh4lH+C69ewtwmi76n?=
 =?us-ascii?Q?EvcOSGPWVzCQKdCN3YXt0/PXH9zbs6qmdSlri75+0LFD5YnD3jXLiJgSLor3?=
 =?us-ascii?Q?x60rm9DZJK/dmyigSD0crE3o2Q3Xk91xOnV0qvODx53OCL2wQnHXDCaqrUD/?=
 =?us-ascii?Q?pUc6T4ymuDWbleJ02UiAYQPQUGsBYgx38q0Gvl6ZyU6ILxW2cHZrFz8OLKkR?=
 =?us-ascii?Q?1a0pVkUiAXo7SN34/UtOc4Edn38hBhe4EHiztRoOKZ+NHL0k/OQbgPMwPWUZ?=
 =?us-ascii?Q?IqDMoYOGlkcxA34PDo8N5VLy3GXlahuONqcfkBPBpU8jn22i4dPV8W0/g+/e?=
 =?us-ascii?Q?ojPMF9KQao+2vWAoZrsI9vuj+VcrYZg0LsMMagbvJqC9+Qo9yDW3uB4qG7S7?=
 =?us-ascii?Q?eI5qcBQYnlPUSffB7t4Wh5wZ/xxgG4DJF8nvxJ/C3lcBn+3UoXL6QynR/4Yy?=
 =?us-ascii?Q?+Jc0grbPtrJnVGII5nGME4eqkRc1OTlKXO9IVEMqeEayGh0sU7bctWcjWKyu?=
 =?us-ascii?Q?olSbJI/MQkxvA4s5JLYSVjk5wriXkWkd3EdrphXXr8eZjE0SrpT6e9ZHmGV+?=
 =?us-ascii?Q?gBSGF78LEsbwIgWwn5ESC8PwBhKzL+Uyjqbioiwzq2Gz/A44vWpd3QKiwj/P?=
 =?us-ascii?Q?T2yTJph6O9W15s1Bp+7Nndo3jPszN4Db5s72rNa29girs0R5DKSSEI8TSXQ1?=
 =?us-ascii?Q?b7CkCNCaBEwpe9RAA2/IF0Hn77N5zhNerMWODOxX5J+gwjaa3v6bO3b4WkR4?=
 =?us-ascii?Q?sqQSX4JeXXGG0PR0cGNsSxc2sfverjLO5NjDr4dk?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73adbc74-c3b6-491b-af2d-08db0a071846
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 19:02:59.0922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQJNn2pOvKUf7s/DrHoOkFfqUnwcNjM3BaEkuw+lj2/gUB1fALxBfV6qdI1yQsiCBCVW88pVJokXKPjBEjzNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1910
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Mohammed Gamal <mgamal@redhat.com>
> Sent: Wednesday, February 8, 2023 3:34 AM
>=20
> relid2channel() assumes vmbus channel array to be allocated when called.
> However, if the guest receives a vmbus interrupt during driver initializa=
tion
> before vmbus_connect() is called or if vmbus_connect() fails, the vmbus
> interrupt service routine is called which in turn calls relid2channel()
> and can cause a null pointer dereference.

Before vmbus_connect() is called or if vmbus_connect() fails, there should
be no VMBus channel related interrupts at all, so relid2channel() can't be
called.=20

Can you please share the log or at least the crash call-stack?
I'm curious how the crash can happen.
