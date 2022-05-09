Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5B5520837
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 May 2022 01:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbiEIXRi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 9 May 2022 19:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiEIXRg (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 9 May 2022 19:17:36 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5CC2A376E;
        Mon,  9 May 2022 16:13:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hnFtLSqBlE3a4CzbPTHRKgkfQFYZpxVBENpieOWtQEipkgqr3lT7FbiAZSrVR4jv/RCFlhRmEhAbTSe90Hat/UKubeENeYDOh+gnqGVemo4ZzBY63r8ccaH2GBmnb5Wv+7NLlTROoPUbbCk60S/aIoBA5zwN1H/BrJgo3GoRCaJ847s/D/nETfsm+PBKB6WK98d+rBBOTyhheGVFrpnXo5Z7m8x9mw71QQl5qH/sCin6lho/AZP8nohOb2sfHtjgGe/dwQGOJu794+yZ6vhGQakTmGIG+j6O17K+dIrbUm2JWPmpZ1XVCDyjtnmIMaH6k86KkKiRGWplYg9Lw0/r3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FFE4d6xEBgE41kM0suW4x+/yl4mfnqBy4dIeXvbnYh0=;
 b=EuPcmxyIlTz6Y61hfdsbGwJJ3gozsUQUnJgzgimHrcYZcreED6HOyvsyxEpbUl8/Kvh6lFQxYej/BP5NEU/ProPfGn6ky1GMQ31FtpZFXZVH6tjSrAZRY+pbC6K2a9ZScpCT54tSMSFy+Ukd3nY0ytAG+JRK/hleGdJM4ko0Z0B/Z5GthbqkxVj2Qqb5HtOgkYTCrLlYXC0BwbequqhcoNkrTYT6LIEE4dXm8iX1lowkye8P5G66LbStYTUVT87uqlE/stF7LsAWZ1VMULxayS9Sn6Cv2cgdhq/uyCwy/+a8HOs7xmC2VJQ9ch9F8dUDUUfFpTgT8EYFEYfJyGSHNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFE4d6xEBgE41kM0suW4x+/yl4mfnqBy4dIeXvbnYh0=;
 b=Xi/T1TGkC0A/gmFELWCHVpnzQm9TSW7C+7zLwE3mXTtBOmR2kHDqq3T1B3PECj+48dyix1B/2Ggk9RHA9dW9vk4q4NRJxwjvdRDxHka9TUSmF2g0S2BYNDJawcneMbHaDLWIbDZLqTsbyPo6OqvYp7cO1uHldzKIStWfKluf+wE=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by MN2PR21MB1200.namprd21.prod.outlook.com (2603:10b6:208:39::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.6; Mon, 9 May
 2022 23:13:38 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::e418:c952:c12b:dcaf]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::e418:c952:c12b:dcaf%8]) with mapi id 15.20.5273.004; Mon, 9 May 2022
 23:13:38 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     Jake Oshins <jakeo@microsoft.com>,
        David Zhang <dazhan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] PCI: hv: Reuse existing ITRE allocation in
 compose_msi_msg()
Thread-Topic: [PATCH 1/2] PCI: hv: Reuse existing ITRE allocation in
 compose_msi_msg()
Thread-Index: AQHYY/pqlfPFie2F3k2vMhV25o5ZVQ==
Date:   Mon, 9 May 2022 23:13:38 +0000
Message-ID: <BYAPR21MB1270A579B909B31FA271FC08BFC69@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <1652132902-27109-1-git-send-email-quic_jhugo@quicinc.com>
 <1652132902-27109-2-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1652132902-27109-2-git-send-email-quic_jhugo@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=19bff981-4285-47ee-afd4-4330dacd7148;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-09T23:07:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2f0aa3a-1c7e-471e-8db6-08da32118cc1
x-ms-traffictypediagnostic: MN2PR21MB1200:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MN2PR21MB1200162F1F2DFACEC519AEEEBFC69@MN2PR21MB1200.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wZl7mvVPdBDAAbUgYgseuYI2Ic6ivAeUv4ESyt4mrjUK3mUCdTn89hpA/eWc8t9jKHpAWQzDfObsEDwIym2fD0eCKjPmL3UXH2hmIf7e8XeRCyV0V30whTdtDSwC+3lSc19UNMT1DIsppRkJjwgOM5HpWeg4sG4EQLtLiBmC7p2cb+0D4LovmZ2RQVtTS1gVZOJfJ3siXkZAfKNry+TRWHBIPTwCYeJPq3bgjv6pJhzWjE9gnspvGE+B3zhX+1zABVZ+YMAr28131uk1OiVfIhmlNiedf44uORm+LBFGjFiVBURXwrCPhSBEy0q0tiygLVeCps5gZMegMEiGqhscd6mSWlkk/rzyGiW3a/6fhU898zIx1E5l49swYfiFUk4NKPUrZ/W3sbPDHEQowE6oJKQldTh5AXZMKckJtgh8a1bjW682yE82yPfuBrSoWfhJwA36h8UeAr+iYS9hjohn5gstRpNhnO1xr6ngOdhLHxad35KLQ0m6ZohJybq4VsXHcLFu+tFwGmgKMTpJkt9rXuMoJHJC/jPk59qFCh3KXExP71jUuo3YoYcx0jzrIkFz9aq2tEK0kcarAzMdAjtEvZ7/ND5LinHOEyvZ9oWwbDdkcryZpsZ/bGwNA7NPR1krfYkCJtmMIyYb8EarbaykQmyHxeVVmcKTdgc923cubANOHmQ7oR2bjonqJwOkzwwFr45iaEjKTD1+BVNxJq8awL14h4k60X2b9NPDOnZJJ3KRKvitwc07x95z0JxsuFXI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(10290500003)(8936002)(38070700005)(9686003)(86362001)(38100700002)(8990500004)(26005)(2906002)(6506007)(33656002)(110136005)(54906003)(66946007)(76116006)(71200400001)(186003)(82960400001)(82950400001)(53546011)(508600001)(66476007)(64756008)(316002)(66446008)(4326008)(8676002)(122000001)(7696005)(52536014)(5660300002)(83380400001)(55016003)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pnPCzp5Lw2bbX+iTfJnKrztKwFhjMuh7hQYe0SVu5KWLi0PqL6rbVWGFsqzo?=
 =?us-ascii?Q?JCaOSF2/Fld9D7XTWVz+SKlTSEkiiG4iWR0M/7+7VT4BLtpB91RGyLg2VCk0?=
 =?us-ascii?Q?SC0uzgJckjhoHIuQSuUIPaDkP9ZUUun8KhdtVn01Js7ZQE+mS/7mOaWcKzAe?=
 =?us-ascii?Q?iB91NfmiC2DSSWMnaO9TBYuo0FLxGf1yS9Wp9AZ2d5srsYRaeQkrZJK3uVcM?=
 =?us-ascii?Q?cKpJcC6HcKgPaqN3xJ4H+5nDPtXypK8yh7fxYuItQOF6T0+Ur6LQQgarXfuN?=
 =?us-ascii?Q?AWgpDNuEQVyBFiGo2T1HmL0ZVptJLW0IRN61nTwx1YJJFW46w0SnYK+wcJbm?=
 =?us-ascii?Q?t/BZQRd91Biv5GrcggJsh+uFCyiWzT/zZWobRJ0Hm3ocgwGScmWtpoMkoVIh?=
 =?us-ascii?Q?3drttjT1rox77+voE26y0wLJ1ODmc5PlRL0oFtvOy15burkT3rCt0QWOojx8?=
 =?us-ascii?Q?Fi17t0KrAcFlbsF45B/EP4aHw1HVAhvtbvFYMuychd75Ts5Oc0WGwqiOI8Mm?=
 =?us-ascii?Q?CXSFDIAObiaW/iVjbdXgsQeCmtPWaZVA/mbjs9AWpAjPb7zjCby+al8lLcI7?=
 =?us-ascii?Q?Xm/f65pB0F3iIb/EJvEoE8UY0rB3YIO3Uc43b4Xbh93DwBQlR9ndo2MDtGE5?=
 =?us-ascii?Q?2pmL0/x36xbHTMedttRQIX/32W9XFB89o+UnlbEzoReYihPq0g+wzhVFUf6+?=
 =?us-ascii?Q?L1Jug5nvIS10EXI/UF9LRAcTDOpIAXciIsyvR/7NNSVR8RRtYDHCXUnfh8R2?=
 =?us-ascii?Q?BL6qz4iZER7wrrpeQCvKgPvJvZ/5U6KwvMD8w0V9UJxmditt29leT6OsZx26?=
 =?us-ascii?Q?QDnXSTNWdbZoJvLne8c+8beuaI+ag0NMo8yldYzZx8VWJwg0ml+Ptsz1HHEt?=
 =?us-ascii?Q?BGPp4rxAkAGyY+WP67pYArMfa1LaZTCRRA+i9wWX0qhMlDZzH5LcXfNOWQ3p?=
 =?us-ascii?Q?9NA4hGVZ7/S1UQwMZEMcR7fsnoMqJtpqp5cwGN4K42rPjfeXzPR7DwqFFdzL?=
 =?us-ascii?Q?/+lPpSYEYLWuyzWKmKFpHKF2N4ZGd5ZWa+sC4uOJ1U131hZaryE7rq/DUeiN?=
 =?us-ascii?Q?xcP2FkAw3xkMXzTdD/cVEUx0mDMCO8OEUq5KDVYfHp2cFS29wUfhtSGRQE/Z?=
 =?us-ascii?Q?nPlg3KSVEMD8muvZNYpI2TKAF3SIRAKHlmMCkpgrV/7V/nkBMDYELreAZxO+?=
 =?us-ascii?Q?eJsYaHmTxVwYQtjWNO22zYwA9mJlAIM5UeLnrEJtM5wGBy/V498bvJHzrhyw?=
 =?us-ascii?Q?JG8knMiOYdV8rjhnbai9oP35BK3E84GJuwRvw9JdseCuDc+8fKL+lK4kmp+U?=
 =?us-ascii?Q?UjyHjE4yK83LOQeJSBsTH8FMB9IIDS9dMwRnD7L/0nycxZ5sZHpyi3tkkOjM?=
 =?us-ascii?Q?O6diGBQv39nchGhZxoiAMoPzPiUnqWk+CyP+azLGShpsb4oUBjr+9Oatv7qu?=
 =?us-ascii?Q?EnnDjQ5sTpOySXBZvXxL/6bwC51cCT1JWGOJhHybxWU5wAEpEY1U8BLdYSMn?=
 =?us-ascii?Q?GqNHQ98qcY6QSZiQFLwArWc8l34diL6Z1XeYiNyF2avK7cScE1tsiSdzAbWt?=
 =?us-ascii?Q?Z1F3434nhMMnwV+qE3UyR7l2piS7DMeITOsrHiZoG3Ai4pZsteDllQEWHqRH?=
 =?us-ascii?Q?ULtOdATt6P+yffV88Okrhl7vwXwiHg0x+qtMmShg0ZlZX1AxMmkAk+n05i0L?=
 =?us-ascii?Q?Y65mHioRWQIstWcAwiRGblEeNjpN+N2zP9B/wYq5POcPxYu/elp6xX7UpXMD?=
 =?us-ascii?Q?Em8fBtbaIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2f0aa3a-1c7e-471e-8db6-08da32118cc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 23:13:38.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1g+Rj5cd74MyaJwJJH3VyHQcebjgpzTUwh3jgzKBMLAQ0eUXZH9xJN+FK10KkdTbCjB3QaHG5deYoT0S5QAn6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1200
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Jeffrey Hugo <quic_jhugo@quicinc.com>
> Sent: Monday, May 9, 2022 2:48 PM
> Subject: [PATCH 1/2] PCI: hv: Reuse existing ITRE allocation in

s/ITRE/IRTE. I suppose Wei can help fix this without a v2 :-)

> compose_msi_msg()
> ...
> Currently if compose_msi_msg() is called multiple times, it will free any
> previous ITRE allocation, and generate a new allocation.  While nothing
> prevents this from occurring, it is extranious when Linux could just reus=
e

s/extranious/extraneous

> the existing allocation and avoid a bunch of overhead.
>=20
> However, when future ITRE allocations operate on blocks of MSIs instead o=
f

s/ITRE/IRTE

> a single line, freeing the allocation will impact all of the lines.  This
> could cause an issue where an allocation of N MSIs occurs, then some of
> the lines are retargeted, and finally the allocation is freed/reallocated=
.
> The freeing of the allocation removes all of the configuration for the
> entire block, which requires all the lines to be retargeted, which might
> not happen since some lines might already be unmasked/active.
>=20
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Tested-by: Dexuan Cui <decui@microsoft.com>
