Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69394730E6C
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Jun 2023 06:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbjFOE5N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 15 Jun 2023 00:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjFOE5M (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 15 Jun 2023 00:57:12 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204832118;
        Wed, 14 Jun 2023 21:57:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mALjnZNYAnQzi9teh1mltkEl9fDZTS2Lr1pHjOyPimZ2v4LlCWEUjXQHGCuxTUYhUCBmU5TzM1hkE56hUa8kkMiZD94ba9vAikDwAtpARlAUc8rVjVXwndx3AjWriZcoubB/CyO1qW/6xs2m3nYPpvGfQAYZNyP7hAQQ8Kp+EV7ETBZJWDohNUrsVKULqbpokiEarvO40LaAbKZWELwkDCSrHTeumiaX8DTSLvsRNoRzHZISon+gQY6OX2g5eBD1XMyUDiFraGITc30/FDvUYa3+NQxVNdkrid9rDLzBP9qSz72Wa7YnRjz2+modKapw7hf5u+qWc2P3TnmQ5HAMkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXKRRudZqBRoATLNZjCOcz2JVp54ixGobyCQwFQXH9k=;
 b=ZsxtOR82D2PoZrEnY+AH6Zi6v2IsatcDJJ3FmgcOKLBFtSzIY5oBRlaWZJrOUJhEZNw+Yd7TV3/9EuegZLUrq0Fn0CvFUuCl2QpfpRrZXSMYqMnBBXFftuaxQIpvZ8xkW74PM5vULXCGade89LaW/3bhm2ndpv8N1WZYevyV8+cTf8/5Aq36X+tNpcNKoz0+UG4b7sYWrk5VB/QfNLPP0Vuv/ZD8wcHzmaxHg3miByl0cb/xa1RO/u9P5BFdK8DqCEM99V33ZVVZBPCoA0Rd5iFBp7TAOX8is7UGXvezi8Tn3/zYAETSiMfmml6VKahamAG/ygl5hN3mPuMaTmkwlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXKRRudZqBRoATLNZjCOcz2JVp54ixGobyCQwFQXH9k=;
 b=bAHoQYU6NDJhJgGxuUTUq9Xop4j1HuzKnobRSJwrn31bkwttTeuw1B1AiNTI5eCbJ9q/rPfteQgLwARA5hDN/UR/b2rJ6cygYL04hYITHdTMBY2Zae0Pnv8ChorpBokKs6iLDcV046Swx79qgPwcsU4JxHsoLcpqgFRZy922318=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SJ1PR21MB3745.namprd21.prod.outlook.com (2603:10b6:a03:453::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.0; Thu, 15 Jun
 2023 04:57:06 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::bb03:96fc:3397:6022%4]) with mapi id 15.20.6521.009; Thu, 15 Jun 2023
 04:57:06 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
Thread-Topic: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
Thread-Index: AQHZmhcEH9Pry/rM70OIGsPwJiaqdq+LViXw
Date:   Thu, 15 Jun 2023 04:57:06 +0000
Message-ID: <SA1PR21MB1335F1236B20CD37553B6DEEBF5BA@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
 <ZG0LTAeV+KMAGXIq@liuwe-devbox-debian-v2>
 <BYAPR21MB168882149A235E16CDECA1D8D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB168882149A235E16CDECA1D8D750A@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=90ce544f-5797-4f90-b34c-2d3f5a2ee06a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-08T14:34:39Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|SJ1PR21MB3745:EE_
x-ms-office365-filtering-correlation-id: 96146e8c-67ce-4acf-4259-08db6d5cf7ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jCalO495gb1MNSSbc1dofQ4/nGqM7oD5QtsotxFMy2oKXMU1hnqeReeXhPzIhl03JbT3iBIpk9s1Ur4tdbWVn3o7/neAYVwHkAS1ta04MTt/d2OVjCUPg87Vl3YBbU2swJwALajWuBYuq+dyVzk/hhHEnlHhu2eEWQHoNIHwFc0FRMz3LdYhck1nl3nRuST/7lcHle3hAI1iYXk+/9HJlynj7IuIYYFXiJbFQSRSHZKMPC3cSrQ2eEXqqgUuSBXXol1MmW+RZTOhTAH6QmFbSUdSW7NGflWoGLhg21velpN8ScKupB9M6mGX+W0WOt0EIjR5RWKWTKycrMRnJntplj/ZGy8c8GBJ5ns21ohc3zvi0VAKXO1Poj48L9gn3kUqNFiUK2WYJY3g0L5tiEz+Jh1IOYYhQpn6Qe7buAHac+/tPOk/n0oOVkqEO4SMEEFQQk022oozPFRHNZnt3t59Ep6YvNqkn/5wf4j2fyM+BizVo2+zd4BiwUUqzg10hsRNnOGcMR7x6FhHh8Refq8bZNj3mXcX9mowy/1Z4xA7brbc76K6jve3ypqUnyIZVHC9lg1F8tx7lb+drxEv2+BwF8eNUODvaneZcvUEDJG/F85YHMj/tLHNas51ToT5K+6VFVp6JtrGhz6YSy8AunKBC28aPGqenTfpeyKNLSIvYPo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(55016003)(110136005)(54906003)(82950400001)(122000001)(82960400001)(71200400001)(478600001)(10290500003)(8936002)(8676002)(76116006)(66946007)(66476007)(41300700001)(64756008)(316002)(38100700002)(5660300002)(4326008)(66556008)(66446008)(186003)(7696005)(83380400001)(6506007)(53546011)(9686003)(86362001)(52536014)(33656002)(7416002)(38070700005)(2906002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tqASGbTXrjoLWU7RK101Q+iokF2zWn8PvFmt7xw2W82RAzS9iiOIVzzHBhWK?=
 =?us-ascii?Q?5FbydLyg9IzF9xTwfBQRhNgw2HfCPmq6i7zdOT6BFVfINNlUP+q7mSJfXB0N?=
 =?us-ascii?Q?whv8UqZhb1rb5Qp7inY8+JA2m/3PfFEXWN0oB573nVw8seStWXCcg5NAv9Xl?=
 =?us-ascii?Q?jjwPxRWdO5NObTL25p4NasHNytqj0ze8MALNVVSXhUyEgesC/vpvLg4/J4Qk?=
 =?us-ascii?Q?NeQTSRkOeC+OFGYe3IyHT4Ho2riABOEpwf0oaDJp+Lu72lc5P96AKsiu1O0z?=
 =?us-ascii?Q?BojXLNpDeneWRtr3SqrDR+iAr/Uk1nV6eljCwICmrAbOSU+V1kQVcrQRmraW?=
 =?us-ascii?Q?C895qJscG5gUPBmNUJbHKUKte64Gn+Qs1hViw/lSkjhZBN254URwDC0iuDKr?=
 =?us-ascii?Q?RW+rd9qDtluE/888bFX9lfe1RPqb+KcjQl4x1SB2u9v/B/uMvXtrOCNyofL0?=
 =?us-ascii?Q?xn+aZBb2+tqnMoMThgJffBw4e8NfeNpTveCnwF6AAc53PfHMlHiO6sfgZ5yX?=
 =?us-ascii?Q?X6d+yPORrCiOyrPL9JSnQcKt4bpnZjYNPZmct58xVya5N3bgfOmk9j6wGaMC?=
 =?us-ascii?Q?qP1exz5rAi9ll0dlT7P/nv9G6YRXiGXhDR8khTQYqZEYzwlWOLdHTwtoX6gI?=
 =?us-ascii?Q?3RCpKxZw4OuX4baKgd25cKrGgRk7e3NXCQkvb2SZvcxbK2egaF9eRG/zOqoa?=
 =?us-ascii?Q?P8ahd+ls4IItoOi3oaSNxiK0k9Yph4nFsLny99Xwa0dp5kPXxtLLOk/REijr?=
 =?us-ascii?Q?ZsmNsq7rB7WZQGnD6LiGmbkd3jFNjk0svjLmkX/TVYDavgGXFaQKOvALEiXU?=
 =?us-ascii?Q?rGRiAKmHKg8qGy/soqtm9dUy6KYdC1Hk6ARE/TEKtk7vTO4JGg3b/gXi9GLP?=
 =?us-ascii?Q?X95yQR0txqPCj1DvyC3m+MhRx/+njiQlkMMdSbMcYh5yDCtGkQ18qsBNqW0g?=
 =?us-ascii?Q?t7O9rdTUTocWpAxrtoNzPWrcANMaIvSkQlZ8G4simPz1FTf2/e5hseuTKs/9?=
 =?us-ascii?Q?rYAESAALgERrpgog6IoPholUKtk8Datcc5K3D30QIJU/vRSbb7Dd2DXzqm3q?=
 =?us-ascii?Q?S2/e+j/LbfRLbllkRmDy2Bq8O+osAwGerPqRKlvGaPbTkN131nhdF1HB8s90?=
 =?us-ascii?Q?SiUrdiEQGkr0pUOmXuFfebCDVD8+VKWdOrKcmvVOc+2mGBS7tt3fiEROMTID?=
 =?us-ascii?Q?cxq+LXT8Wby5PU4GHArtLg9V74frnmQpCffQZVplwIdcqbRHpz63zm3LZ1r6?=
 =?us-ascii?Q?UVhPb6x0EYqcaTZlDuNFQXmQrE6VjLN5TG1FD75YvNyKD9ekenmqPA90QRVY?=
 =?us-ascii?Q?weVAFeB/wyJcnXE56OEye/twotSaczxBwAadt9BuKm0jlwmAAAijBZN45ldS?=
 =?us-ascii?Q?o/ZjDFf6K2zTim1Fa93IX91zOBxCTYW30X9V8LDbjcxlgWVm+v7jYbaqGSE8?=
 =?us-ascii?Q?r5n6anG4xMuCjU9C33bn1ieIhOiN1lR/acTpY93xJBfBspCFdB1/XY0iboHh?=
 =?us-ascii?Q?IiZWEVkW9pmahTH+R+uG9vRLWO5c7Jy4V1FCKZc62mYwTQH5+XbgSCG7O71T?=
 =?us-ascii?Q?kfqir/GhOSNDTQJ3Z+zuGTTcnyK4UcCXJ49JEVN8+QxK5rZa/xE4Z1X3S++y?=
 =?us-ascii?Q?NLxGlgdosfmrhpW6bSXkNnI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96146e8c-67ce-4acf-4259-08db6d5cf7ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 04:57:06.8112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x1rGS7Ek3OuX3CrEPhcmHrHLdFUsO4lSlu+67u6U+QcAEOwEn0OGILdDdxpr2rlCDIY5SEuU1/UpwFFWjphoXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Thursday, June 8, 2023 7:39 AM
> To: bp@alien8.de
>=20
> From: Wei Liu <wei.liu@kernel.org>
> >
> > On Tue, May 23, 2023 at 10:14:21AM -0700, Michael Kelley wrote:
> > [...]
> > > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > > index 0f1001d..3ceb9df 100644
> > > --- a/include/linux/cpuhotplug.h
> > > +++ b/include/linux/cpuhotplug.h
> > > @@ -200,6 +200,7 @@ enum cpuhp_state {
> > >
> > >  	/* Online section invoked on the hotplugged CPU from the hotplug
> thread */
> > >  	CPUHP_AP_ONLINE_IDLE,
> > > +	CPUHP_AP_HYPERV_ONLINE,
> >
> > x86 maintainers, are you okay with this?
>=20
> Boris -- Are you OK with this, and could give an ACK?  This small patch
> set fixes a problem introduced into 6.4-rc1 by other Confidential VM
> changes, so this fix needs to be incorporated before 6.4 is released.
>=20
> Michael

Hi Boris, gentle ping -- I hope this patch can be accepted soon as I
and Tianyu need to rebase our SNP/TDX patches on this patch.

> > >  	CPUHP_AP_KVM_ONLINE,
> > >  	CPUHP_AP_SCHED_WAIT_EMPTY,
> > >  	CPUHP_AP_SMPBOOT_THREADS,
> > > --
> > > 1.8.3.1
> > >
