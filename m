Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9968B230794
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jul 2020 12:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgG1KYB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 28 Jul 2020 06:24:01 -0400
Received: from foss.arm.com ([217.140.110.172]:60420 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgG1KYB (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 28 Jul 2020 06:24:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7B741FB;
        Tue, 28 Jul 2020 03:24:00 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 920BE3F66E;
        Tue, 28 Jul 2020 03:23:59 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:23:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH -next] PCI: hv: Make some functions static
Message-ID: <20200728102357.GB32448@e121166-lin.cambridge.arm.com>
References: <20200706135234.80758-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706135234.80758-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jul 06, 2020 at 09:52:34PM +0800, Wei Yongjun wrote:
> sparse report build warning as follows:
> 
> drivers/pci/controller/pci-hyperv.c:941:5: warning:
>  symbol 'hv_read_config_block' was not declared. Should it be static?
> drivers/pci/controller/pci-hyperv.c:1021:5: warning:
>  symbol 'hv_write_config_block' was not declared. Should it be static?
> drivers/pci/controller/pci-hyperv.c:1090:5: warning:
>  symbol 'hv_register_block_invalidate' was not declared. Should it be static?
> 
> Those functions are not used outside of this file, so mark them static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)

Applied to pci/hv, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index bf40ff09c99d..5c496b93cea9 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -938,8 +938,9 @@ static void hv_pci_read_config_compl(void *context, struct pci_response *resp,
>   *
>   * Return: 0 on success, -errno on failure
>   */
> -int hv_read_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
> -			 unsigned int block_id, unsigned int *bytes_returned)
> +static int hv_read_config_block(struct pci_dev *pdev, void *buf,
> +				unsigned int len, unsigned int block_id,
> +				unsigned int *bytes_returned)
>  {
>  	struct hv_pcibus_device *hbus =
>  		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> @@ -1018,8 +1019,8 @@ static void hv_pci_write_config_compl(void *context, struct pci_response *resp,
>   *
>   * Return: 0 on success, -errno on failure
>   */
> -int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
> -			  unsigned int block_id)
> +static int hv_write_config_block(struct pci_dev *pdev, void *buf,
> +				unsigned int len, unsigned int block_id)
>  {
>  	struct hv_pcibus_device *hbus =
>  		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> @@ -1087,9 +1088,9 @@ int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
>   *
>   * Return: 0 on success, -errno on failure
>   */
> -int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
> -				 void (*block_invalidate)(void *context,
> -							  u64 block_mask))
> +static int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
> +					void (*block_invalidate)(void *context,
> +								 u64 block_mask))
>  {
>  	struct hv_pcibus_device *hbus =
>  		container_of(pdev->bus->sysdata, struct hv_pcibus_device,
> 
