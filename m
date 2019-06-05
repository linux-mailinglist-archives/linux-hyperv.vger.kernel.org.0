Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B4364A9
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Jun 2019 21:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFET1T (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 5 Jun 2019 15:27:19 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38744 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFET1T (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 5 Jun 2019 15:27:19 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 466471510FB88;
        Wed,  5 Jun 2019 12:27:19 -0700 (PDT)
Date:   Wed, 05 Jun 2019 12:27:18 -0700 (PDT)
Message-Id: <20190605.122718.16555291488036753.davem@davemloft.net>
To:     hch@infradead.org
Cc:     stephen@networkplumber.org, linux-scsi@vger.kernel.org,
        linux-hyperv@vger.kernel.org, sthemmin@microsoft.com
Subject: Re: [PATCH] revert async probing of VMBus scsi device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190605190722.GA19684@infradead.org>
References: <20190605185637.GA31439@infradead.org>
        <20190605120640.00358689@hermes.lan>
        <20190605190722.GA19684@infradead.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 05 Jun 2019 12:27:19 -0700 (PDT)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 5 Jun 2019 12:07:23 -0700

> On Wed, Jun 05, 2019 at 12:06:40PM -0700, Stephen Hemminger wrote:
>> > Which is true for every device, and why we use UUIDs or label for
>> > mounts that are supposed to be stable.
>> 
>> Not everyone is smart enough to do that.
> 
> Sure.  But they should not get a way out for just one specific driver.

Agreed.
