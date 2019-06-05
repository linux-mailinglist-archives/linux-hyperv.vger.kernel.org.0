Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6D3363C5
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFETHY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:07:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfFETHY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4sSZMnbHl7rMQg4gM/HXXx/UDEBLFqxqrgmk6RB6L/k=; b=OaTjMp4c4WxcsKLyczDk2G2+y
        0xKVcj+OU3Ow+TGJFrVyLwDcYr0YhSHMpADcfnLK6THqppTVaTZADsUmw0GtGCJYKrcg/jvHHL7Rj
        TCUHfBOvn52FC9op1ZInyqgCkZDQiE0/bipxe/DowFRfNxQWH2P2XOyEd7k1H5Yn0qBISqpCIBCVb
        cFdGpOVrHUOWb0CtRcWsvfIScC0Few/cglm4cuTR71nPg3tRt6uPnzWpGxd1yqFeGvdQTmdjU1ZkJ
        p5CHsmnc7mE+s8yPnTuDA2F+tpn72YV9AjbyYMybJrz1XvdC9zeUogWYGQJm688jUIIX6A1NktZXm
        IOYXPjXtg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hYbFr-00059F-6C; Wed, 05 Jun 2019 19:07:23 +0000
Date:   Wed, 5 Jun 2019 12:07:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
        linux-hyperv@vger.kernel.org,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH] revert async probing of VMBus scsi device
Message-ID: <20190605190722.GA19684@infradead.org>
References: <20190605185205.12583-1-sthemmin@microsoft.com>
 <20190605185637.GA31439@infradead.org>
 <20190605120640.00358689@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605120640.00358689@hermes.lan>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jun 05, 2019 at 12:06:40PM -0700, Stephen Hemminger wrote:
> > Which is true for every device, and why we use UUIDs or label for
> > mounts that are supposed to be stable.
> 
> Not everyone is smart enough to do that.

Sure.  But they should not get a way out for just one specific driver.
