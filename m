Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED13544E0E
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jun 2022 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiFINvW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jun 2022 09:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238119AbiFINvV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jun 2022 09:51:21 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064021.outbound.protection.outlook.com [52.101.64.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C4D4C434;
        Thu,  9 Jun 2022 06:51:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gxIBJe82mMQVSniRd2H2oGyBD8qejVpH16Z5fl5lM4PmGYckVJrw8wo/dBVKzcHNsMNAfjW4+PuqMLfiJPu5EOmPfkem0PK3jKrsBlwzvjzp42GVwr5X6flPfecvJ9cqjMkQcYVp1i/ZYtPwVV0gQxhI/iGSJ1MwQQVTB5L34X2tCxgPIr8kveJK6scxNhgJGre88h9XQDplhs1ttXgPtotm6ESq8iaXvdj/XDfLuVAoObDporYpZnnluUhiMWzADmV528TiNqMZMvfdjQ6rXK8hKSfqtMGJrj57VN4V1alz6ZZ06HoPz4M4DZoknUTxAOBk1D+BOoh7xXbrOSeeBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR40Nk067KN4Yy5liorZyGrDu0EJEjqpa4dlVWm7vSo=;
 b=RTLXs+gtDFKOCZhi3Q41K/EDZPWVbhTtCopOGV1KPIr8NbQeH+oqzgv1/EZHWNXcRhQ6yyPzoTJYi4NJlYVUMnMP+uZNU8K/uxd3jBkQVluFep1B4WdlYqnIPQWxwPzRIWVOMK7vIboCoqvgI7Yg48mQonywKW/+E0QwM2840pvfJpATvGgz+Ykeal9uR6EjXqpemViGluJH9WF5LlwvhAoo5T2JQIw55v/uBXU6Q5Tplvx681t4Upr5LTBDU3EV8vLwr5mgnntF6i5x5RZOfLKR3+j2XjFbo9mXG7ToN4dxCktioujQ286QJwwIXjiKCZeBX95I0wN+J1hhO1arEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR40Nk067KN4Yy5liorZyGrDu0EJEjqpa4dlVWm7vSo=;
 b=c1RSrsZmbNQ/LlPlWTnyJzEf7pyd96gprYadKJXbU2oBjOSx+N5qrY8OA5uMP7rnbqMiKwzux8TwntWjIb4NsPOpxItahkDPynneKqF5mGmJ8mFjFfqwoekGCx6XBVsNH5XV8TQlTVlttHlNmroAfUypR3mX3BLVqNvoJlVr4R0=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by SJ1PR21MB3410.namprd21.prod.outlook.com (2603:10b6:a03:452::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5; Thu, 9 Jun
 2022 13:51:18 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f80c:f3b1:a285:4a2d]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::f80c:f3b1:a285:4a2d%6]) with mapi id 15.20.5353.006; Thu, 9 Jun 2022
 13:51:18 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: [PATCH] Drivers: hv: vmbus: Add cpu read lock
Thread-Topic: [PATCH] Drivers: hv: vmbus: Add cpu read lock
Thread-Index: AQHYe8GfNCceoJwZg0WDRLHF3z1Wma1HFoEQ
Date:   Thu, 9 Jun 2022 13:51:18 +0000
Message-ID: <PH0PR21MB30251360E8081A96F5A33F3ED7A79@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <1654752446-20113-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1654752446-20113-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0a9be4d0-1dd4-4276-990a-e6e44613ade9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-09T13:44:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23626f6a-b6cb-4f50-3b53-08da4a1f20ce
x-ms-traffictypediagnostic: SJ1PR21MB3410:EE_
x-microsoft-antispam-prvs: <SJ1PR21MB34101AF07E34F33DC587EAB5D7A79@SJ1PR21MB3410.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Vbb3G1EuyR0Eohox3NwrwRanL045gTg00boi5GFaFRL1siOEv9JgfmLNtCsWvc2cTAK0pc+OlCihsVeoNtDMdrUvD+9ho5VLV7uiY+KMnXRFWWEmVUjeMbzm40TPWQ3AOAwp8JpV6cKaCxqJ822soeOcVahvTEgsm/zitghjeyjGzNXmH1Yz51G+DyCJdOO6U238ZieEDjXtVer6i/u+bflXhxWYZ5YDHDdZYt8QM8xdeqiAc/PTL/ywlO0lkWsUMFxCtOl2QpzFyzrhSy4Ux/VTKcThxSizNHKpPJxGabPNyQR2PeO8CankEQ3kvBzoufVvkPluSpLjkErAfwLKzPdpoSWNB42bT7QkeeLqe414IlXNkGzG6SQ2htd1rnENCzApM0GxPUWXhxKpHVb4++4o0qgr2lL/zAZi/ii6RtUC0ILzJVFjW14rGJKfd+CRTkp/EbYfQ2FZuEZRcWqaudfhGGbi6DDKbYdJs2aCA194bzlBTUIGUHtA5yNQs28akU3jp0VMZA0jWEbrs8Y6ALQ/QlByAyE9Ug7MnOgdjnxklF2nfmlMCfuyhsn+PmNdms1ZznECVWPN1CPcf5ey1mo+aYQpkRJLlrGXxY76ZyIaYNKxu6WnYgj/nUxvMr2gkTkefLtgJuZ0ol7MzxpLkUhkuM1V9dNU19uijWWSLgmDJvjAP5o24VYMnVE2ibfi0UShtXGKG0a5cRLiqv+FQ5WJbRR7I01Fl5Ef10QPxH5h9OtocUnMKpZ3T0E2H7l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(9686003)(6506007)(33656002)(26005)(55016003)(83380400001)(7696005)(122000001)(82950400001)(82960400001)(8990500004)(38070700005)(508600001)(2906002)(6636002)(52536014)(66556008)(71200400001)(316002)(66446008)(66476007)(76116006)(66946007)(64756008)(5660300002)(186003)(8936002)(38100700002)(86362001)(8676002)(10290500003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UJ16uPuKbRiMoBMq4ipvuH+5HsA/lb0uArQSoGjGzxBseKJfA9CgDVshFwb/?=
 =?us-ascii?Q?9JF9PlNUMKrZmo3uLVheDikr9xUa3WTOfBfMAD4+zUtAc3tl3yMEjhH6CLjZ?=
 =?us-ascii?Q?gwa/pvGgkG6/Ibt6lNh3r40+ti+kuS4x6Qm2Pt//G24AUmHeG3/sj7D3IEGx?=
 =?us-ascii?Q?4FtjPtsRLmW0fM7pg14CicXD0VxLzaSY7GrTA9e5Nb0EwsUAQRIl40Mkmh1r?=
 =?us-ascii?Q?QiYVExTrvSHk9+UWB0pU7mbCuAIrt/VCwn5FborVay13yBl26ObFE2suvI6P?=
 =?us-ascii?Q?/phUbiSt/c+D36Ky+GN/ixDX3aQovGkRrsKqc+h5t/KVTD/S3qdgXeanZFGo?=
 =?us-ascii?Q?WD0738EyjDril6sGWx/DRVGGLnr8f2fZvzQDPMEST3LVkUqjKM8y30FZv9w3?=
 =?us-ascii?Q?18e3wdwVCfPz1LltcwaWhvDhxMrLiiBPuYNfAPSHrTq16F+LYaYTiFRlKmu0?=
 =?us-ascii?Q?F6g32JJxbqTX0UgcRuuZIKRNsa8jviK9JqHoaZqRMANTcMxj7eWymPTv5/zB?=
 =?us-ascii?Q?eFoutLK5Wg/XrE5g1IgKTcNdn+S2GaSwvCONkIaAJiVW4qSvoz9/AkHKjHvd?=
 =?us-ascii?Q?BSTyDh1OKe9zZYYhEYJVzPK3SX8sEU9+KYoG1jrKhqsNGQN3cIkBnKVE+VHB?=
 =?us-ascii?Q?cdlwYn5/e4DtgcK5pwIB3yur9BWt00xdAIxmRY9jKtqeFEwTEMBPN4hLj+6V?=
 =?us-ascii?Q?oZw57hi2GYx01cKkNpgqGIpHqSCr0UT9bCb/ns3jyezW1pfb8WhW3LO+ZrZd?=
 =?us-ascii?Q?8NlM9URYJ2/7YsKhoDJwRJvk+yxFcHQkynu+51YvwrfvcCSWESrFf5FWmC+W?=
 =?us-ascii?Q?Ur2txRapJF9MuYh+F334h9lu7IyA2wr8s2YcTR91DGicPCaD1OfLEa4tdyjl?=
 =?us-ascii?Q?+AvVf20lQ3eMGDjIiX2pOjnDS2ykvOuYqtUtOh0uyPb9ClgO4XHqI9ACHLGk?=
 =?us-ascii?Q?tRsSnbputVdGAnY7qS/HHSe5ztkmi51pxZWos2VuEdvsIX9SLtxZMouEslXh?=
 =?us-ascii?Q?tJTJTMEFRGOPEmIwq/HLiXCVBX0AuRcTZ6SSJeAQgeOPW8vzXq+OHAbhPAqo?=
 =?us-ascii?Q?FNiD3rsuqsCYnYgu2nKc48rmyUc2+aZuclMMcduyrg7EKwH7FUSPBMrhQkV2?=
 =?us-ascii?Q?eLMVCFL9SBgWRl8TLW96iWy/08bIGx2zW61pq9EmyDcJoE4zKNbFp3DyK5P7?=
 =?us-ascii?Q?zakgOyjtdk7lCjmpWa5Gdady11WpLkV/RNlDlXGK0opCpdiRnCAYDzv4yAzi?=
 =?us-ascii?Q?dmttStmmsqaQWvCEFutJNTYn9x2jl3icvR+OLyRetEwoiqJfgO9xsQvFCk2P?=
 =?us-ascii?Q?uAoL1cLb+Np56qv9VY+BDM5pGinjL3ZFuSHMjI0QOnDoXnSVbLeXezw16n3d?=
 =?us-ascii?Q?aqLWQg4o9LaiNUZZEnScyL4d1pKSxAf5cOhJOiX80JithzEJEcjJTMqZJ5Ml?=
 =?us-ascii?Q?xHkQUmiQ9N87ET+9t4OJWjTOoiRkffo7tq67BZ9JbOS3AQ/m8j64CvqLSjUA?=
 =?us-ascii?Q?xZHxe14hi9D8bScMNCw37MmfsxyzxmCvsXdfiLmLrckXvZhZgmhIsip0wTYZ?=
 =?us-ascii?Q?4/DhreOA3/a+1+R2RybLh4HgONEbxGgBiKsGRR9q7Nd3Vm15BhidFZriMhgF?=
 =?us-ascii?Q?rsmbXaThe+6NwMnkVFfJRlb0Xy4yD+iagkK1+pZ+fF969LD5Pm6AyBT3JtZ6?=
 =?us-ascii?Q?W3jakcoGpAS/QghrdYGCNxLPlJH30tiIBimtG1NVU+gtUXmGRazocZEvnrj6?=
 =?us-ascii?Q?sAwmEcCC8tXuj3r1VOt8gX8wQrcZ2Ac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23626f6a-b6cb-4f50-3b53-08da4a1f20ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 13:51:18.0549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dl13IunBMT1KBTiYERSUsS5uYZyndQKDn19QOJ9gEphUsMBL+Tu9UvgmiOefKoxNdZQgP6ATgGhIPuboLAUKhHUK0id/QS+Plrv/x50F5dA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3410
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Wednesday, June 8,=
 2022 10:27 PM
>=20
> Add cpus_read_lock to prevent CPUs from going offline between query and
> actual use of cpumask. cpumask_of_node is first queried, and based on it
> used later, in case any CPU goes offline between these two events, it can
> potentially cause an infinite loop of retries.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 85a2142..6a88b7e 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -749,6 +749,9 @@ static void init_vp_index(struct vmbus_channel *chann=
el)
>  		return;
>  	}
>=20
> +	/* No CPUs should come up or down during this. */
> +	cpus_read_lock();
> +
>  	for (i =3D 1; i <=3D ncpu + 1; i++) {
>  		while (true) {
>  			numa_node =3D next_numa_node_id++;
> @@ -781,6 +784,7 @@ static void init_vp_index(struct vmbus_channel *chann=
el)
>  			break;
>  	}
>=20
> +	cpus_read_unlock();
>  	channel->target_cpu =3D target_cpu;
>=20
>  	free_cpumask_var(available_mask);
> --
> 1.8.3.1

This patch was motivated because I suggested a potential issue here during
a separate conversation with Saurabh, but it turns out I was wrong. :-(

init_vp_index() is only called from vmbus_process_offer(), and the
cpus_read_lock() is already held when init_vp_index() is called.  So the
issue doesn't exist, and this patch isn't needed.

However, looking at vmbus_process_offer(), there appears to be a
different problem in that cpus_read_unlock() is not called when taking
the error return because the sub_channel_index is zero.

Michael


