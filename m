Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AFD36592D
	for <lists+linux-hyperv@lfdr.de>; Tue, 20 Apr 2021 14:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbhDTMqh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 20 Apr 2021 08:46:37 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:53729
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231251AbhDTMqg (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 20 Apr 2021 08:46:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aEMSyW1A/uIhB7gq4FiRJZR+xjaF2MSMswzIOOKhcLA4Wgi0KW45e7uHJlG9glCktnuwcwAQ6b2rFB80ZoIj2SZPttoqwAfyrbubeLzgikmzoJ7WRBGcWWPe2tMPVXxPm8zDX+MpNLE9e3w0ggf5kpvihTDT7VUryP4XpdkHo9KltD9IoJ+l0ic8xjgAWhSrzgFmLK+jroO8/LIjELG8arYgQpWAqFKODetzPklo4PvNsKjgDGNGeJ9h1nQ/j+D1+NpTfXn+auZRFS/dwYvRR+bHE76xGOupBan/74mV+HJT0XiHpuoLWa9S+YgG/jdILC/S+TU1CIaa6ngN0LFk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdnUslMBQ46HBWwPjvFsxYOnVpl1I3MEcutv78h1erg=;
 b=Lb+m3pFvz1A7M+wh8WvPX9upGajHybPzM7Bh53h7uxoj6bmQVjxP6QY+kKR21+c39Jn/BzbztVXzbPapXo8EJRD+lkIW4TpsRQX0y4ewQJkZNcOzS85umWvkWdjNtwsd/7HI51vDg26+cUT4V8GdCMbPP4dKU8RD7Cf3E8mlukMYgkKPObaeqEjd9X6pvV4vliIHc0dB/J5Xqlvu/l8LyK6eWmNw/uMVoctCsG991O6G61he9T/olBWtEWvNlw4eXaYPgIpNNInT2YWhglESGh2CaDZl8wq2AZ3HNm/kWAFQrGCAkb8DrnhUuwMSV6WvMsRXh83CUizhnyx7YylpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=microsoft.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdnUslMBQ46HBWwPjvFsxYOnVpl1I3MEcutv78h1erg=;
 b=PjGrwVO3O5iDt1lEVXw0bsJOTdC7ImitATk0KoWvmGRiaaPSvt/8tlpOUgVWBZus09ZSD2hT9um5F97fJTALxStXKZxoDhegBmDS1xHJs+IwUqrFd450D+KUTDmjFvwpZNCP17R335owj0Dw91ER9FWdPlnK6E0YO46FySy2a02e00VBKYWV+kXDpU60Go8VbVEuuLW6dUiiF1sDQKRNnn3wKBGYaIVtSRatIgQuNcH9eNA3HhVZ1xROLiln4sI4hjXjwzLpEYQ7CGwt8y3Lg0KhIiYmOEv+AGJR0+ObNI4VWj6HPd2l7trF/sH7o2d950/qFdS1aZIabMtGw5QTdw==
Received: from MW4PR04CA0152.namprd04.prod.outlook.com (2603:10b6:303:85::7)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 12:46:03 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::1b) by MW4PR04CA0152.outlook.office365.com
 (2603:10b6:303:85::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend
 Transport; Tue, 20 Apr 2021 12:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4042.16 via Frontend Transport; Tue, 20 Apr 2021 12:46:02 +0000
Received: from [10.26.49.10] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 20 Apr
 2021 12:45:57 +0000
Subject: Re: [PATCH v3 01/14] PCI: tegra: Convert to MSI domains
To:     Marc Zyngier <maz@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        "Thierry Reding" <treding@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rob Herring" <robh@kernel.org>, Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bharat Kumar Gogada <bharatku@xilinx.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-hyperv@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-renesas-soc@vger.kernel.org>, <kernel-team@android.com>
References: <20210330151145.997953-1-maz@kernel.org>
 <20210330151145.997953-2-maz@kernel.org>
 <316e8be4-fa70-75e8-8483-ae38036306e0@nvidia.com>
 <638a9996-c762-fa11-b740-6a41d4a83bcc@nvidia.com>
 <87fszlqria.wl-maz@kernel.org>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <67ecea13-3036-0d2d-fa89-46f896a06693@nvidia.com>
Date:   Tue, 20 Apr 2021 13:45:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87fszlqria.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc0a6703-f7ae-4c5b-d2e8-08d903fa41c6
X-MS-TrafficTypeDiagnostic: DM6PR12MB4484:
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR12MB44847EAAA5C0251B60467682D9489@DM6PR12MB4484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygVCLWN/DeK6M2Eb8daDTh3PECA7xPve8aVF+TLy7zhyTnp8BKK+d31qk8hqgj3WQ+V06bfTxzY2XSigpNE3cbxbkE56SUXy5Rmpo4UHmKkgg90vZVyYC1U0bzx4Q6tD5DsyrKVDy40KxsUX/X6PYnkZsA1BbsLM/N36/2e5TRnHUFVBaunuFFivr6qYF63kfiGtbPRDCYlCcQWHE7nuQ17GjLo+kQ8SAL3sVtdppnHQJGy00S1PRYcmp4bgsWng+tDwhns2hYnyXdz7butLwsRaGpDfOREk6cr3KXXq269WUHUMjW0jqAcwJjUkER3LnKDtfCE7AUb+hysl/oF1xLNyOIkJswLTfk4nM6PtSR8aaIU3O9xyvNOiDdrSSaOOZcxJnqhJy5TI/Trd8ZOBJEfttrM1/yfNws1hQVBOCi4DvR7UTupPG1AVCiB3d0xQJEikGFk6ZfjKhNMrw8RdYEcGqrL/LPVCbAS8YA9ql4IXmOZ2tw9H8DezBKXQcVundPt+TTIzitduu4zEvffNEA1gNhXMge39t+HB6YmUSf3Sib7hUh0mu8VTJHiOFRO0yojMdYU9m+8KgdX2kmXtr1buDkjI1g6n5XK/qLavrJDYJP1FHV+eFqPGGilAa3tcEk82o7mWtg+9HMhFlZL4LDsqqsuDWO6XjXgEnQTGuYOwLQCcL12xMxXxm4yGScEu
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(7636003)(7416002)(2616005)(70206006)(47076005)(54906003)(53546011)(426003)(36906005)(70586007)(82740400003)(31686004)(8936002)(6916009)(478600001)(336012)(5660300002)(2906002)(86362001)(31696002)(316002)(82310400003)(16576012)(26005)(8676002)(16526019)(4326008)(36860700001)(186003)(36756003)(356005)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 12:46:02.8842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0a6703-f7ae-4c5b-d2e8-08d903fa41c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Marc,

On 20/04/2021 09:39, Marc Zyngier wrote:

...

> The following should hopefully cure it (compile tested only). Please
> let me know.
> 
> 	M.
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index eaba7b2fab4a..507b23d43ad1 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1802,13 +1802,19 @@ static void tegra_pcie_enable_msi(struct tegra_pcie *pcie)
>  {
>  	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_msi *msi = &pcie->msi;
> -	u32 reg;
> +	u32 reg, msi_state[INT_PCI_MSI_NR / 32];
> +	int i;
>  
>  	afi_writel(pcie, msi->phys >> soc->msi_base_shift, AFI_MSI_FPCI_BAR_ST);
>  	afi_writel(pcie, msi->phys, AFI_MSI_AXI_BAR_ST);
>  	/* this register is in 4K increments */
>  	afi_writel(pcie, 1, AFI_MSI_BAR_SZ);
>  
> +	/* Restore the MSI allocation state */
> +	bitmap_to_arr32(msi_state, msi->used, INT_PCI_MSI_NR);
> +	for (i = 0; i < ARRAY_SIZE(msi_state); i++)
> +		afi_writel(pcie, msi_state[i], AFI_MSI_EN_VEC(i));
> +
>  	/* and unmask the MSI interrupt */
>  	reg = afi_readl(pcie, AFI_INTR_MASK);
>  	reg |= AFI_INTR_MASK_MSI_MASK;
> 


Thanks, that does fix it indeed!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
