Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A049F59A1B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Aug 2022 18:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351883AbiHSQNy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Aug 2022 12:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351868AbiHSQMs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Aug 2022 12:12:48 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB057113DF4;
        Fri, 19 Aug 2022 08:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bguwWRzJOQy9trFWoJTIgVDGNhHIprvfgT3lLCMgsDATZMox6hAb0xW/GUQOkCCfGmTcxA1T0lYIyQNL7a6SXUNB6WVtxPjWxYFXZWoAIus/xvc/KIRoob5A27Y/uCE2XZncsODUUZF+sfluLVRbpfnOyZ191cyqk63pOjdaD8e8gxx2wRkyjPvdHniZ6KvJseVOVmLpKaKnWZfQet7dyAxPNDhBR8xzodtApOL0/mUoqh75bCNzOPJqvgW1TaiftmEShYclplpRqqb0McR3bQsJkuweXvbadMtcfMfSGmekcTkHE2IjVEL6kGXsb7Cy9bC0j4n15mqKD9RSvK9fBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDqDoWPO1MpfxAy2lBH9OHYVOxqrLdz1H1D4uBAzFdo=;
 b=Mooj8LNjcEWieJjZJCscM516ntro6MPV0gLetcZMHkMow13Uf2lwkEugLh3Q5+ZkKPGC7xDaYaU1jABIvWzAmJWCgxTs9TE08zS2MQB43tzWSfU8LgaXPFa/oPo6IqI0ijwNHamzg7fuKEPyzPOk1SEjL1OcNWoyw+ZWrE3/0RCNGSev70FIzQNR2EsH1Ynb0iuePROo/Ai1DUfzk1QL1Ml6x3rJbYL1jWpeoLyQFkk1BBy90zg15UMAueeZWs97PYEKAmcZu9qHTzqi5xKWQrW5psJfg0QGZ66jF+4RJkck03PY6k3MyCL1R6Isu8rCq8aXUiobL9GSpV+fMsEXFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDqDoWPO1MpfxAy2lBH9OHYVOxqrLdz1H1D4uBAzFdo=;
 b=AtSbLNJiFEvVaFjGgeRHfZUvV3m7EzxSRv/iu+jqgZWtXgZjPN+qnIcWKpGCqgZGjPNkdHXgYxBBHnSf9NkH25A/xHuWam5NBjGAMZdyczsIFRT8ZqpMJL+X9a0UGWVXwlnquS7WP4tZ6Ft7BWyEeH62elp/B92rBJJUkB/t1AM=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by LV2PR21MB3182.namprd21.prod.outlook.com (2603:10b6:408:174::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.4; Fri, 19 Aug
 2022 15:57:20 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a4e2:7dce:4d6b:c208]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a4e2:7dce:4d6b:c208%5]) with mapi id 15.20.5566.010; Fri, 19 Aug 2022
 15:57:20 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
CC:     "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: RE: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
Thread-Index: AQHYs+O32fMcX0s9O0OiWaZVRKUYJK22YCXQ
Date:   Fri, 19 Aug 2022 15:57:19 +0000
Message-ID: <SA1PR21MB13353BD0E507FEF441B99FE4BF6C9@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20220815185505.7626-1-decui@microsoft.com>
 <20220815203545.GA1971949@bhelgaas>
 <20220819155242.w32vcwobt4ucvpyv@liuwe-devbox-debian-v2>
In-Reply-To: <20220819155242.w32vcwobt4ucvpyv@liuwe-devbox-debian-v2>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=1d909c2e-094d-4e13-9864-4399743e83c6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-19T15:54:28Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c2eccdc-6291-43a5-1c0b-08da81fb7f65
x-ms-traffictypediagnostic: LV2PR21MB3182:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RYgUwgmohPiI5es+TuqZ27kxy/0tQucUEdLYcUPbwZjWuH6vnXGDez12EG9ZqEmJJ/zEuDiDEm0jJHkcbMznJf1v6ZsKwYFNQ2LAEJjQyJ3O0QdtF2TbagUlvuSfuICyr1Dx1cXN4QdtxHX0FvhqcAg66OeL1fOFMj577CxDoqOdfCo356zUbNhE2lf4xmExFqHG5fCjpvERJqq64hbit1zgdkd4LUgUL7djZTfzG38UO0PUSdvh+DOtHNTxmkJwL4ep4plIOJAZH74g4eYMjVG+tSD3WusYJtE5GAB5ChSIoE9EU3jfJEmZBxjIjdBSj5TmDpJ5m7yhDCXIWe2qDXjL2C8neNevHP2Dhv6f+L1VaBRLDkQZcx9M3VkQ6FCKY/GF7JNjRh3KqXHEd5vCarm0uzxoHOfyY0ABxPSOFmWLcQbau+OaFTtGa7FDtpZc/y5BpiXC+NC604TiW/536Rh2H0XTHRhcRUX75i1egcda8SsKKlG14BvnFtnsH3cx4Mv6s8sIt7cJb1qjW2upu5tbXvCNDcQwmsPcxLtsb8d6gsq9C81mEpWOkQvGD+4haTwTHSYdUeUBGDKTmzhNRtgT5xV2/7HvWs4ES8/sRCk7zSitX7/0sD3e2L6kUW2h8MO4UrJ4WPueZ5+CibaeNEsSC2wdhnGJu+5CQXlRGbo5IVcOYsoBASn2gyOFfqYfOUjrm5RnHsAtP/Z5kZGZN6b+PoHiAEYZZatjb3EAEgBFvZaRajzueXm/EJ/zboqf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(136003)(376002)(451199009)(38070700005)(38100700002)(86362001)(10290500003)(82960400001)(82950400001)(64756008)(316002)(122000001)(55016003)(8676002)(66946007)(110136005)(66446008)(66556008)(54906003)(76116006)(66476007)(4326008)(2906002)(8990500004)(52536014)(9686003)(8936002)(7416002)(5660300002)(33656002)(7696005)(83380400001)(6506007)(186003)(53546011)(966005)(26005)(71200400001)(41300700001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+TdtH9GSTyvZijh6RLRiz8XPnvqkIjRGOOWU5rbka2rhsgDAZ0kl5dPid+R8?=
 =?us-ascii?Q?7gGllxvFzn8gC3t6sktdCLaZ4bHjsUmGb6QtBqmW8y1SVA7HprIFKZxpHLET?=
 =?us-ascii?Q?R70L/4CM6sQyacjFqRyiQKHYjya3Uoja2xLuIVTQEZdgsQmgwqSCzW3NJKmO?=
 =?us-ascii?Q?EkiBRH3Bo8o8BX63L8M55A2M3bigmo7G27+fVpMVoHrfjv0PAy5SxUoa6dab?=
 =?us-ascii?Q?eBfauEiSqr/JMJ1GOoq1n1rZ2hVfEba3RjLxse8qPAyxRVAHuYBaePWZfEQS?=
 =?us-ascii?Q?0zCqlxOhGX/asF727EZJG0eWVGeqO6fUFs6GslOwoDZMWZjjEm1+ivdjGsnY?=
 =?us-ascii?Q?Yb4+CYxkluvXA3W2KFCe1E1sao+9VMohir+U5Ebk+4HLJpZDo0MLP86XmUTN?=
 =?us-ascii?Q?BiAAy/54LWiqrxuCbr6D7OFR/oVFkvLxsCBEamurWcF8MGYv/ZZ2eXap07ca?=
 =?us-ascii?Q?D3O6reI2kjNeXKT+wQiDgvBJmlyx4U/t3Y75BKaHuuslX9U321szuFPDgAqt?=
 =?us-ascii?Q?yWJkJZVd7CnJ6vBaQM4BfB1VX6OA8PoLaJCrU2BNfYUt/VXFia1n0KzBAxq5?=
 =?us-ascii?Q?aWdPe9VwbtUgBVYVmAhVz6dxQ4vmv2+zUZnjg7yVIGalMyZQ8Kp3ra59ar9H?=
 =?us-ascii?Q?U3Mu10zjlIUsa+lxjf+SqFId5+bNnN+7RFzziu3vKNlJ4BZ05ogyVGEF6Zf+?=
 =?us-ascii?Q?hAr9Z76ArMZm3qZsx0YQYfSekfYNlULNCzbjI+RmxdJKVA4msHhAhyiYYz9P?=
 =?us-ascii?Q?/0yRYqD4P0qOzVH6DjSc4elqEtFPJNP46zgpqQMaPl85WG/4vd9LD8se9/VE?=
 =?us-ascii?Q?LhxC88a2XvJYCgprDFIEFkXsWnae8Qqn3n8EdUbDXNcDg2loyDCLeBPmHGQK?=
 =?us-ascii?Q?tDHMn50xTOziwcgqj78IusBDP0tvVbM/cy2vHN8wLMHC35l6TuFdcfkITfrv?=
 =?us-ascii?Q?aAQyleiPs8+dSiqDBK71niZa6UWI9Vm1ZqWGn3X36IXamgfLnbNT3ib7piL5?=
 =?us-ascii?Q?nFPHdCk3kmEbqL6rmL/zhDhNVRnEFdoG0IEvXYq2NiBGBj8/Jr2B8NqSSM2B?=
 =?us-ascii?Q?aqxrwTbybaf6RgHIIFfLwDXC/OO+HPVzwvFMwR+PgWxZQUPnbfjbBIKlj2fg?=
 =?us-ascii?Q?HCj+RW2pbM9J870ZOB9VX5I1AmlUPkos6SemIKgpKOCyVRTxl6DP22/rdIS0?=
 =?us-ascii?Q?Jyz+mCsL/8xoJg0hHTgF4kGFabUQwQdrYcBYi4EvMAPa5bd94l//jy0r1r1C?=
 =?us-ascii?Q?00OD2aoe8zk/7tLl67PISqG0AwQdLuSGbVXotVUcHE/z5GRUIg1pCKwCQyE9?=
 =?us-ascii?Q?ABxR3z/Qh98ZWtsdBQ//nn5v2uUWqeeNORfvXr8tIjRoiR3iZ5DPaQiyObM6?=
 =?us-ascii?Q?hvZe7JJTcP9sbQTyg5YrhQyRILztbh8TIOeQmtDSPrEw1sr7fkpI12gui64r?=
 =?us-ascii?Q?ocUw3m/4mxh9eQEQjjKaHQsaKJ7YtQQ4tf6Lt2hvceqh8YVoGRxmudKD5mY1?=
 =?us-ascii?Q?t3Sv0HNIzSnNFcPzMh58zjM20OUcF3u9AbtqywMIgG15+M2RTt/bqMnpxt+p?=
 =?us-ascii?Q?vwaUlisBa1znY34LeZS+LA8YJ/mYgj/aZg5FFMfZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3182
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Wei Liu <wei.liu@kernel.org>
> Sent: Friday, August 19, 2022 8:53 AM
> To: Bjorn Helgaas <helgaas@kernel.org>
>=20
> On Mon, Aug 15, 2022 at 03:35:45PM -0500, Bjorn Helgaas wrote:
> > s/definiton/definition/ in subject
> > (only if you have other occasion to repost this)
> >
> > On Mon, Aug 15, 2022 at 11:55:05AM -0700, Dexuan Cui wrote:
> > > The local variable 'vector' must be u32 rather than u8: see the
> > > struct hv_msi_desc3.
> > >
> > > 'vector_count' should be u16 rather than u8: see struct hv_msi_desc,
> > > hv_msi_desc2 and hv_msi_desc3.
> > >
> > > Fixes: a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> > > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > > Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > Cc: Carl Vanderlip <quic_carlv@quicinc.com>
> >
> > Looks like Wei has been applying most changes to pci-hyperv.c, so I
> > assume the same will happen here.
>=20
> I can take care of this one via hyperv-fixes, but ...

Wei, please ignore this patch. I'll post v2 of this patch with v2 of the ot=
her patch.

> > > ---
> > >
> > > The patch should be appplied after the earlier patch:
> > >     [PATCH] PCI: hv: Only reuse existing IRTE allocation for Multi-MS=
I
> > >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flwn.n=
e
> t%2Fml%2Flinux-kernel%2F20220804025104.15673-1-decui%2540microsoft.co
> m%2F&amp;data=3D05%7C01%7Cdecui%40microsoft.com%7Cc8ab6638b7d747b
> cddf008da81fadc12%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C6
> 37965211688628404%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMD
> AiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&
> amp;sdata=3DRb2MfkSFmJ%2B8ze%2FllN0THBhODCtmnZ8oSMB0EOn20u4%3D&
> amp;reserved=3D0
> > >
>=20
> ... this patch looks to be rejected.

Correct. I'm working on a new version.

>=20
> Thanks,
> Wei.

