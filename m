Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445483649F
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfFETZb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:25:31 -0400
Received: from verein.lst.de ([213.95.11.211]:44630 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbfFETYd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:24:33 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3B6D0227A81; Wed,  5 Jun 2019 21:24:05 +0200 (CEST)
Date:   Wed, 5 Jun 2019 21:24:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sebastian Ott <sebott@linux.ibm.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Oliver Neukum <oneukum@suse.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        megaraidlinux.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-hyperv@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: Re: properly communicate queue limits to the DMA layer
Message-ID: <20190605192405.GA18243@lst.de>
References: <20190605190836.32354-1-hch@lst.de> <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 05, 2019 at 01:17:15PM -0600, Jens Axboe wrote:
> Since I'm heading out shortly and since I think this should make
> the next -rc, I'll tentatively queue this up.

The SCSI bits will need a bit more review, and possibly tweaking
fo megaraid and mpt3sas.  But they are really independent of the
other patches, so maybe skip them for now and leave them for Martin
to deal with.
