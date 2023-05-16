Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CAF9705026
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 May 2023 16:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbjEPOE1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 May 2023 10:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjEPOEV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 May 2023 10:04:21 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF8B83D8;
        Tue, 16 May 2023 07:04:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYE4jdHRiv45KeuY39zLs+Q9N3yOs+RTnGk/9uBp7+E1iZIJsD9ud9HjAmCjovpKowpB3/B/l3EtjQxu4pMR0q25enmfhNHkGIA42bYV+jk1hQcArZ+pH1nAXOgdguYVQDvZSkSVCbvD9ZZh+DvpeyTF48aTAYF1ARXRvfWz1l0TZpdceFN75HQ8VPlGQ4lETbwKbodXFl7DDgEs0krH0XohVvWV0Bo+Wc3Uwf2PwNqcnwzKgSIRO3Rb7YoqTrV5/VkGMySGbmYfavE6onBUTh0BYworKXRQfDPwiXZfPNsrgSDB/QDzZPV/oq8g5bP/g0U0zua/PZpchJ8RGYGyrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uTyUbpkdymdaOoe2JuQ6syL5vnOQMW9Kf6/7YFYXjU=;
 b=JvGyvRl/V5FkKC81yM8lPUe9dL5v53+M7LGbgQC/CI9XZm6gpQYUt6VxzHbDAjvRFaMJhTqcY3ZnvNB7NKs6LKDqcYwc5uWSimqkmQohU24IYkmFaUIlAr8b1+B7RyocbLQOu6bk+psjRBZNi0hrqeZYfb4BxYPeJOtSBVZmg3XePQoJNMVCyvlgdUXlPPq1hVsRmCcAmjRCUIZ2OYNWXsTbKPkbbaQeRY+RvaLM/g6ifsEcY/nsas4oFN4ecPpykAhdvpDsrqqdBmklNKUPyBn3e2bdEfCV/xOymusDC1LqhoaRrF/XdZLzrxe7setiNmNzyAd1SiJu36lMU0drlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uTyUbpkdymdaOoe2JuQ6syL5vnOQMW9Kf6/7YFYXjU=;
 b=fFJyFhH57hF7kh6nbnBazSt4aaR9Me2F10YvqlcP5/HmbN2bHtvC5ScS8xEPYay3VLSh1YkYN5YThXXF/xX0uHnM1ShWzwwYCsm6iJq075wpbQOVBz8t5d2fKUKj887sz17llVwByHAtf1TDo9O4NaVTgpsRgRxtAYRWCH3AxJk=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA3PR21MB3865.namprd21.prod.outlook.com (2603:10b6:806:2fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.1; Tue, 16 May
 2023 14:04:09 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::a4f7:2466:97b5:bd31]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::a4f7:2466:97b5:bd31%5]) with mapi id 15.20.6433.001; Tue, 16 May 2023
 14:04:08 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to
 scan present CPUs
Thread-Topic: [PATCH 1/1] Drivers: hv: vmbus: Fix vmbus_wait_for_unload() to
 scan present CPUs
Thread-Index: AQHZh1ParG5yjCRdyU6eR9Obx0AjP69cnigAgABNgJA=
Date:   Tue, 16 May 2023 14:04:08 +0000
Message-ID: <BYAPR21MB168882CE892921640D202BE0D7799@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1684172191-17100-1-git-send-email-mikelley@microsoft.com>
 <87pm707i9n.fsf@redhat.com>
In-Reply-To: <87pm707i9n.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c2f38eac-0cc1-4f86-855e-d22c02d43ab3;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-16T13:48:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA3PR21MB3865:EE_
x-ms-office365-filtering-correlation-id: 5d59e41a-b764-453c-64f9-08db56166ad3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LKg6zA8XupcRgWldB7IRnbjo2cibTBmm7ZnAi12/PWmd5/6mljgPKesBFu1K560PUfWWzYZ57vvj+eyl4+9MJMnRNm55QcJID19NseoN+gtUoJUJrl5wSTvx76YcLp1FRA23gtMNN+q5Vjytah01x8uy793zRJDELEwammXXI62lydDgScUf9mlA1dvB4lwL865n/iY+9jkh5ICriVIu7hoAAbCw5FgAgG8vHXWPMyoDe2h9wPKuVr5Qbwfs5x8co6lHlVd3uh7lnZRRqZnEhQ83e7uGKtT3Ee92jj2RrcjP5lqlI+MdkhMxK1fo8T/o0NPVvpCU9Ki/PTj21ZOtMTWaR4rhHVfGf2lyItVxzT8JtJQ5eDZeI+mAakYleugTZ4/OPUGA+vcOlxVEamOTvHNPUzGYZk5VyZeZ371U2qf0DMCJKZEGyFPMDBur8u5WXyFQcalOH3Ahm3jkGLEvilJeRAedrmOBuSL+K1whoglvgNlEUozvTqA+NlGqv1kKsS97HqjTi3Cs23NiOf/YyxBZ44oqhZ3ihHFlCOcYTpEdvOea4LO4ZezZnFfgjrwAHmY214UV5OdeoW4egyg3EcBfdIvBsnKr7z+CtwYQodppu7hxT+lbNEiUdW74j9cySuovO48mKGIULl1bpSRckOELycDx1rLV52eKzPQzRSY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199021)(55016003)(8936002)(6506007)(26005)(9686003)(8676002)(107886003)(83380400001)(2906002)(64756008)(478600001)(7696005)(5660300002)(10290500003)(41300700001)(4326008)(6916009)(54906003)(786003)(66946007)(186003)(82950400001)(66446008)(66476007)(316002)(76116006)(71200400001)(8990500004)(86362001)(38070700005)(33656002)(82960400001)(66556008)(122000001)(38100700002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g5/orHQ5IAFM4C/4farEX1futgb/q9EjZ5QyX3wi1Jne4jYk8qlMIuj2bAXF?=
 =?us-ascii?Q?YbyqHF15YrTgEc4hcq9s7vl1KNDKPtW83UijXkFBvMS4HGbTNlsm5ATMKuVZ?=
 =?us-ascii?Q?P2OH2PFCtDfKvh+HJJ1jL00ojA18bl1PmFH+2cOKFq5JWlBVXUNja2VJ2BN5?=
 =?us-ascii?Q?7nGTQ8Tzp2oD6wfVQYC1myeKdCbtrOZtwPc9DcDRorh8yu2CUL7kCyGP/ZrP?=
 =?us-ascii?Q?llZnjj7HjqcXs3yY9AOQZBXCRiJJlhqZUSKPawuEmpE2MGS494v8iKoSCpHF?=
 =?us-ascii?Q?IpOFCGfBEK+Fuh0JR87yArj2MZqvTht8bgOw12iBxFnCBJsJzPKz5I1dL1Da?=
 =?us-ascii?Q?yZC5h1sC7yjQIqgk0gz3Zpf5tp3SuueJB/xF0ShlQhJIUdP6EpYX/5/TEpgR?=
 =?us-ascii?Q?3K77dSgabJFYeUq26xYaPA77A5UDvSf5nzdoW9nOGqLMR7zNxl7Fq4/cJj4E?=
 =?us-ascii?Q?x5JY24AS/YWTJk+TQRsuKOGpSGNEzcxZbw9mVhMZaiQwvON6Y209FKokFf2/?=
 =?us-ascii?Q?ZdqnyOI+xrr8eoJKT/1FKaGSzs3HgZhGQmkPlxBgeXmA7iN11oe0PP4mcsee?=
 =?us-ascii?Q?BoPWBYSq0gkGIZBm/QugnSumTAr4TJ6IcdJWmgq7sSz/LMnaUF/OUeZHQ4CX?=
 =?us-ascii?Q?b4uHXxCa83GYVwYYm493BmfDtfnb5fCPIL9PK1ZANMMsoY3IeHNeU9KWv81e?=
 =?us-ascii?Q?Qs5QzdzQSsL+XsmMzwp+gX1/4pBU3ysi1xu84foEtfb7QDOLgWOIE52Hj/Sa?=
 =?us-ascii?Q?Gseh7BYriRSRHK4NxudiZ4uMD96xQdeHKKUf8HxyF1PLcdfG8x+Uy7e/ski0?=
 =?us-ascii?Q?f49cpCtZXHoQDNt5cJGI6GPDsuiHxdEm5lLpuC2fbXwHdduKhwzemXWBM+es?=
 =?us-ascii?Q?SVW703VvYzOmTbAXZ4KJRNiaruOjvA6Pa7H9hOwwSeh0aF/usnd6RjiBR+8d?=
 =?us-ascii?Q?mQB6Fk3wHfqJYGJ2QXwuUEclv4NcSQosjdtRqwIKH/uHhXCWlVMrjVpdOh7I?=
 =?us-ascii?Q?LEB7Grey5FrbWv8cPdp8/5dDH6Thtx0gbvLGjK3LhZtPZ5poTRegkiBcPq07?=
 =?us-ascii?Q?JeqXRaJtSbnvtGvfN2eNliInKx3D1NJWlJuJkCSQeGqjlH9poDvB/Oe39IGy?=
 =?us-ascii?Q?f3wusPjqImuR33fy8MQN5KOcqZGSuNOB+EYw+XuaQ1EOC9R+Q8K+r6c7I5xS?=
 =?us-ascii?Q?9p2AT4WjWa9jFGgGGoyNkH7ICTdcwWTV2ZnltuHLW/d0Irxh/CLPZ4teOmsp?=
 =?us-ascii?Q?Tq4GUKpBEgXHAIjqm21QwPuA2GjMN2kbZIPEnVd+KKBYRprOyAANG48FV8kO?=
 =?us-ascii?Q?yXnJs2DCx26XPSKEcjBe/hs2ptaPprRYYrCg+WtG14SmfYtJ/x1Hh8NWJgzW?=
 =?us-ascii?Q?7u5+skdS+8OplZ1u60dgwkQbhC2KsgZq6NDBSTRhRQKGrvCBy1tIS1JwZU6m?=
 =?us-ascii?Q?+7vQo5Rj2ln6A8WrxLGrazT5wH8bPR6CPd5CI74k8F2h84OK49rWJh+vAvR7?=
 =?us-ascii?Q?Fmn5I2EUdy5xund449r5NShCWAit77sH4wl0yZ2dAVsgGTQvFkow//oi70RG?=
 =?us-ascii?Q?PLKiD1wqw8FOlrzEtlQ6lZGDyzEqsDeMFh/j+56GRHVPEp+pLGbVP61xa3TU?=
 =?us-ascii?Q?bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d59e41a-b764-453c-64f9-08db56166ad3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 14:04:08.4397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsW2pRbWx1fG4Jd4aAN9s1VxbuPUxTtLZWrWiZd3wrfZ607SrIUzvDkggukrDWk8TSJhktAE9d0S2q3SoOXyyJw0hVln8EKNAHCWuHMiL1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3865
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, May 16, 2023 2:=
12 AM
>=20
> Michael Kelley <mikelley@microsoft.com> writes:
>=20
> > vmbus_wait_for_unload() may be called in the panic path after other
> > CPUs are stopped. vmbus_wait_for_unload() currently loops through
> > online CPUs looking for the UNLOAD response message. But the values of
> > CONFIG_KEXEC_CORE and crash_kexec_post_notifiers affect the path used
> > to stop the other CPUs, and in one of the paths the stopped CPUs
> > are removed from cpu_online_mask. This removal happens in both
> > x86/x64 and arm64 architectures. In such a case, vmbus_wait_for_unload(=
)
> > only checks the panic'ing CPU, and misses the UNLOAD response message
> > except when the panic'ing CPU is CPU 0. vmbus_wait_for_unload()
> > eventually times out, but only after waiting 100 seconds.
> >
> > Fix this by looping through *present* CPUs in vmbus_wait_for_unload().
> > The cpu_present_mask is not modified by stopping the other CPUs in the
> > panic path, nor should it be.  Furthermore, the synic_message_page
> > being checked in vmbus_wait_for_unload() is allocated in
> > hv_synic_alloc() for all present CPUs. So looping through the
> > present CPUs is more consistent.
> >
> > For additional safety, also add a check for the message_page being
> > NULL before looking for the UNLOAD response message.
> >
> > Reported-by: John Starks <jostarks@microsoft.com>
> > Fixes: cd95aad55793 ("Drivers: hv: vmbus: handle various crash scenario=
s")
>=20
> I see you Cc:ed stable@ on the patch, should we also add
>=20
> Cc: stable@vger.kernel.org
>=20
> here explicitly so it gets picked up by various stable backporting
> scritps? I guess Wei can do it when picking the patch to the queue...

Yes, the kernel test robot has already warned me about not
doing that right. :-(

>=20
> > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > ---
> >  drivers/hv/channel_mgmt.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> > index 007f26d..df2ba20 100644
> > --- a/drivers/hv/channel_mgmt.c
> > +++ b/drivers/hv/channel_mgmt.c
> > @@ -829,11 +829,14 @@ static void vmbus_wait_for_unload(void)
> >  		if (completion_done(&vmbus_connection.unload_event))
> >  			goto completed;
> >
> > -		for_each_online_cpu(cpu) {
> > +		for_each_present_cpu(cpu) {
> >  			struct hv_per_cpu_context *hv_cpu
> >  				=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> >
> >  			page_addr =3D hv_cpu->synic_message_page;
> > +			if (!page_addr)
> > +				continue;
> > +
>=20
> In theory, synic_message_page for all present CPUs is permanently
> assigned in hv_synic_alloc() and we fail the whole thing if any of these
> allocations fail so page_addr =3D=3D NULL is likely impossible today
> but there's certainly no harm in having this extra check here, this is
> not a hotpath.

But consider a CoCo VM where the allocation is not done in
hv_synic_alloc().  In this case, synic_message_page is set in
hv_synic_enable_regs(), which is called only when a CPU is brought
online.  If the CPUs that are brought online are less than all present
CPUs because of kernel command line options, then we might have
synic_message_page values for other present CPUs that don't get
initialized and remain NULL.

I should probably tweak the commit message to call out this case
explicitly.

>=20
> >  			msg =3D (struct hv_message *)page_addr
> >  				+ VMBUS_MESSAGE_SINT;
> >
> > @@ -867,11 +870,14 @@ static void vmbus_wait_for_unload(void)
> >  	 * maybe-pending messages on all CPUs to be able to receive new
> >  	 * messages after we reconnect.
> >  	 */
> > -	for_each_online_cpu(cpu) {
> > +	for_each_present_cpu(cpu) {
> >  		struct hv_per_cpu_context *hv_cpu
> >  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> >
> >  		page_addr =3D hv_cpu->synic_message_page;
> > +		if (!page_addr)
> > +			continue;
> > +
> >  		msg =3D (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
> >  		msg->header.message_type =3D HVMSG_NONE;
> >  	}
>=20
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>=20

Thanks for reviewing!
