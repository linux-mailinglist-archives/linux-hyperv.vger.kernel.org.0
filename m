Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1510460FCFC
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Oct 2022 18:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiJ0QYo (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Oct 2022 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbiJ0QY0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Oct 2022 12:24:26 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11020023.outbound.protection.outlook.com [52.101.51.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1A913F0F;
        Thu, 27 Oct 2022 09:23:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFE3KyqrVwnQ2lSvhXQ4Rq/NScFBWc9bAsNu8Y9Xf+loaSzBtXBve9B2xKlk67g/rgu27wtAbyeCee22vQJ1DmlTf1on6LI2SBaKdWc+KRJBoq7PaCt++QscIEP9q7MGply6R9BC7Ic0Dddoyph5Od85FtK2LPHaGa4KCMJGuoLOOLJoPVXmu7GKOzqwFhYgGbAz9D4SwWSymvbOzZSNkkuuMHhY5gkl08U0QMpwSQELYkduHqOghTrGJ4ZeiNmLpB2l8vxktWixYSV+M+LVVE3K00tyVvO/QL7HEjRAX26Bs/OesC/KIXwHehRNSWDXkZ3gJxfgvaFY+XMyW+gVAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0j6HheXjPjnSuH+TV1OrRcMqCBRr4+Q5CdTL2s1jOQ=;
 b=nNdUUCINAOVrNzm16kRSzhUXx9yOkjp1/2QA2+Xrj6/FzjLyfWML9XUbfp1InfL4LX7vq0nQalC8Sq9ovlGlsP6s6z7K+jdWCcsydbZXRIYT1+FiBodbp8fyk/108e1NdYQmnoGH8D38xIb5YtFuzjWHfSVnACKmh9db52SbQE+6qp2nYpefadixNDebsC/AVVu4VIfgQ5yKB+wJny/kYNX5mhItcMXIfaWr5B1CM/g2zbjEC+jrdVI8ka5W+OqZSUkxMb7lE8yVoFXrS7TF2cWWzIcofGsDSqEQZ4VMowZpznW0lzo/g4pljok66KDpuEsxcsJJ7Bh0xPbvNZYO6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0j6HheXjPjnSuH+TV1OrRcMqCBRr4+Q5CdTL2s1jOQ=;
 b=elsJWIT/vXJ3yRk92A1G63HGEY2vDO9cn2Zx4EiPupyNTBVERun4RnDwJkmPyn9KslzssStjjPxI3ziL7ZWlnADZeErxavvRZzpo2IUDw9oGLYJiZhYz9hUwRiD3BqahzXCM8b/nqw76dMCdUp+taqM1RMdHZVVMxeZCDSTmWU0=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DM4PR21MB3248.namprd21.prod.outlook.com (2603:10b6:8:68::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.9; Thu, 27 Oct
 2022 16:22:53 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::600e:e49e:869e:4c2f]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::600e:e49e:869e:4c2f%5]) with mapi id 15.20.5791.008; Thu, 27 Oct 2022
 16:22:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "quic_carlv@quicinc.com" <quic_carlv@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>
Subject: RE: [PATCH v2] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Topic: [PATCH v2] PCI: hv: Only reuse existing IRTE allocation for
 Multi-MSI
Thread-Index: AQHY6AEkY2TDPPxGMUaLzNKIsTJo9a4faSzAgACBzzA=
Date:   Thu, 27 Oct 2022 16:22:53 +0000
Message-ID: <SA1PR21MB13357BE81A7B7DDB47BF6FADBF339@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20221024233342.22758-1-decui@microsoft.com>
 <BYAPR21MB16883E16789C7F8DBC965CCDD7319@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16883E16789C7F8DBC965CCDD7319@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5d66bf82-f0a4-4933-b4a0-1e42373af77b;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-25T18:07:06Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DM4PR21MB3248:EE_
x-ms-office365-filtering-correlation-id: 6bfc4a62-8f00-4b61-dcf5-08dab8377ffc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pi++Ln9Klsz6o21y/ftFXPfqAa2FvxtjabIF5BD0+qMVHnAIonL6gJAWHn23p6+ak0RS0qyx0bMf30kgjp7PhLl2O9zDAR2KFuVMR9uuw4/XG9XYpsYi3adCMoZrN+eScLwTj3adHHiioBo1FDf42TUmGDxuaQ0SsXgCi7vXXZ5EAwHLR6bMUp0Oe5Tjcds8aH5YzXa4Lf3qsw7e5VBA7+xH+nwMCZ06f9BhSipzrU7cv6vdodQZWjoQtUdseOHCyVOzMdkEQ11B/AIe7veai52jxLrncUz6i+sKZlyVa0NbUI2xanrtKeKFn445GqP+lOGhS7rSBmSsJMHk864owskazHNCzpibfM4b5j+BlEFaODFeOgiD4kJO3hl5BSbg+z2o5Ff0peinGHyoHKDqf2ZxjA59H5hqTSwMyHIoCBOE472isGzm270gdBGWAmOWoga6EtpqN1iwODzG38xWnfOjCo2oL3pkZ7xJZOpYvS7bSeNWGespMQiaK/SFrMfZiC0okfaFt/Bu9sE2Xt16AL3Q0hlqBrHawkEhnvFUbI700grvuZ6FDP+4ret3eE3EPRkvdpCwJ2pz4Ffcgw0ngLBU1l2j/5xImnsBNBdTEiYQ74UMcXAJUn9yHNLet9Iv9peySwjAjzSmT+ZL6tNF02YnwJIXeqai5mTAUmjCbw4zOoGLkbw9W6eRzZ/a/FCGyCojlDYNCSSdVSIjYGmuoFOp6YVeHiaYJj7Da17L9+LVjrvmQctN+fuw+rWF87WhDFaEFipIOWvY88xHTgFu8XfF5VcHElNRI4HITUDGrjuQkN/1xgRHaTqC6IJSlB9JCUb9S3Gr0syRgAzAwAc+uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199015)(66556008)(66476007)(6506007)(7696005)(66446008)(8676002)(66946007)(33656002)(64756008)(76116006)(110136005)(6636002)(82950400001)(316002)(10290500003)(83380400001)(82960400001)(8990500004)(38100700002)(921005)(122000001)(8936002)(52536014)(26005)(55016003)(5660300002)(9686003)(86362001)(41300700001)(2906002)(38070700005)(7416002)(186003)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5v2XiQj1J/QRUo5fWOAkQP1OHiyKREmThiSo6388dymcTPxDO/ipVLLUHMBI?=
 =?us-ascii?Q?rbR6METm3QXMieqRdDAqQ2d450AS6kKK5C8e47gU96d8YzlkSQXCvx+TIPdO?=
 =?us-ascii?Q?rBhYNsHmWcC6Ce/MWuncucgb0mjqgZLbbmVJ6QYTtZURYNm+LkjF+K2v0UA8?=
 =?us-ascii?Q?ev/e9AlsQG4lkRLNEHjeHVxuVGSCMvqaZe1TIvgIUatDyBM+SU90HY/npdZs?=
 =?us-ascii?Q?fbuORonmdeS7MF+UhrGKOAZW/nFM9lxbo6aqWuyTprEJZw9JqwcbTXiLTU3M?=
 =?us-ascii?Q?pqopdDsaj5TJqnD10/A6A7Ek40Dw5JkAJ0YuYNdoiSfqcTXsdrRqZhxq7EpA?=
 =?us-ascii?Q?uEXo1k/eSE08epMvC/vOieplOOzzOiXdX8LgicW0mhzlLu59FM69NQ80bPA4?=
 =?us-ascii?Q?apTms/a0iDBSLBQnMLpceWcmWUTeIM4BRRsrdAnEwTQQGVT3iGyJJrsko/jW?=
 =?us-ascii?Q?rXRRDd3wIj9Tq7Vo+uKVRnEYtKZGtMI33/W5c12KIJU5iKdduWT3os7ZYkox?=
 =?us-ascii?Q?SoFvmyfrXSJN6B1Gwar7DsqaH+sMX6WzF4r4Vcm9PcFRKVo5nrsLX8+JMARx?=
 =?us-ascii?Q?8PQAHOmXo+ct1epxfpCLzQLMblSh5pZ3KAbuYODX7nf6h1Yx50/pp0MYswfF?=
 =?us-ascii?Q?VgKhAiqI+Jp+I0PRkbiWTCuTsKfCwT9WesqHJO16X+Jkv2NV2fwFixjhUDeY?=
 =?us-ascii?Q?W32baBGWyUrpZMQgJvYnJDdwII5AxxmsGdVwyuoTFm8OO4EYFF88vapiaggL?=
 =?us-ascii?Q?99T3F0EKPFGnxEzWful8m+cXng6KgrfItI1eDikWkp8ZBkHUL96bBeA8oNC/?=
 =?us-ascii?Q?yCfnWFeFsD8gvtHRt2auEoT+v6TtClFIghvLHweIyLfhfctJJ8lwd606WHv+?=
 =?us-ascii?Q?T5ECxeJASs0E4anmDFurUEpPTa1T94LLm3NaHem/DBwOomEMogrZsaXrIN3F?=
 =?us-ascii?Q?oKa3IHXQqL0OZQuY63KaZ8iZyeDWSMVb4jRNO53wZIsDnCv1Dlh64RRJ3nl9?=
 =?us-ascii?Q?5FjrkvCiaPvpM4ekDLALRFcl/zZRsKXypc6z1kyY3ccyFX4Ta5ymQ0dlA+uf?=
 =?us-ascii?Q?EMmo5q+xGsJXm0jHtOnESlz5ClXsSctMaPluH2qsp85Q74aVK4VSh+MiJUgw?=
 =?us-ascii?Q?Jov3d30PYskSR4tM4obSHIXKaya4/iJ70zQaUaQ6dUfCI/8SsvyfqIuwV3ws?=
 =?us-ascii?Q?AItHunEHr2Xhq1afSFC50uHGahU4rcoM9SuhfKNJMYYe2WwOAX6T5qXLCfvT?=
 =?us-ascii?Q?0o3wb5OciGBnfdVqVOs2kh/Ej+hmcpeCjOpwN6R/6Qp783wnjGnY/LX56zeV?=
 =?us-ascii?Q?vc2xZ3J8xpqV50hFm2G9Mhi+QmY95xjlzMy+aU15bH/064J6BfN0PXpoplg8?=
 =?us-ascii?Q?Rq5gOAttdBhyQt1L9+6VS3lnXOgxhEZoeWeChpJOaK1THyyThj+GX92Qhltc?=
 =?us-ascii?Q?/IJC/Y8UOnRvtFtQWUXHZRdU3xptC7XXk6EpWLlwpFM1Eyaqnq0e4gAKzVho?=
 =?us-ascii?Q?H9Br2Ziz0WkavbkahaDHt6oBtf7pBQ4Mvhk+KDfQT/1tds4EvxZ3mXHUe/Cr?=
 =?us-ascii?Q?WIlnmooXAyUjhDQUzyO/5Q75zUF4aYDwwkiIU9iu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bfc4a62-8f00-4b61-dcf5-08dab8377ffc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 16:22:53.5868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYakQAur7XeDMl5N2SLP+ukHtGl14HGOh9BfowZH9Jw0cDWtrVZRO7lGVHa1jKHpbc1vxMlfeVIQrU12cRBK3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3248
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Tuesday, October 25, 2022 11:18 AM
> > ...
> > -static u32 hv_compose_msi_req_v2(
> > -	struct pci_create_interrupt2 *int_pkt, const struct cpumask *affinity=
,
> > -	u32 slot, u8 vector, u8 vector_count)
> > +/*
> > + * Make sure the dummy vCPU values for multi-MSI don't all point to vC=
PU0.
> > + */
> > +static int hv_compose_multi_msi_req_get_cpu(void)
> >  {
> > +	static DEFINE_SPINLOCK(multi_msi_cpu_lock);
> > +
> > +	/* -1 means starting with CPU 0 */
> > +	static int cpu_next =3D -1;
> > +
> > +	unsigned long flags;
> >  	int cpu;
> >
> > +	spin_lock_irqsave(&multi_msi_cpu_lock, flags);
> > +
> > +	cpu_next =3D cpumask_next_wrap(cpu_next, cpu_online_mask,
> nr_cpu_ids,
> > +				     false);
>=20
> I have a modest concern about using cpu_online_mask.  The CPUs in this
> mask
> can change if a CPU is taken online or offline in Linux. I don't think th=
ere's
> a requirement to pick on an online CPU, especially since if we pick a CPU=
 that's
> online now, it might not be online later.  Using cpu_present_mask would b=
e
> more correct.  That's the CPUs that are present in the VM, which won't
> change
> over time since Hyper-V doesn't hot-add or hot-remove CPUs in a VM.
>=20
> A similar concern applies to hv_compose_msi_req_get_cpu().
>=20
> Michael

Here cpu_online_mask is better than cpu_present_mask.
It doesn't matter an online target CPU becomes offline later, because when
the CPU is brought offline, the kernel should automatically migrate the
interrupt to a different online CPU.

hv_compose_multi_msi_req_get_cpu() is called when a PCI devic driver's
.probe() function is called, and the .probe() is called from the context
of pci_call_probe(), where CPU hotplug is temporarily disabled/enabled, so
here cpu_online_mask should not be an issue.

Thanks,
Dexuan

