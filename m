Return-Path: <linux-hyperv+bounces-1560-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7368A859532
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 08:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BB3282F70
	for <lists+linux-hyperv@lfdr.de>; Sun, 18 Feb 2024 07:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFE06FC6;
	Sun, 18 Feb 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sUx5icqP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A877563A9;
	Sun, 18 Feb 2024 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708240240; cv=none; b=oETqN752Qx/3X9WH0NCrX5IAmXSixh6R5+vi9HWV1PyOLDphZwnJyYt4YvYsiK6cFvkRZWdlBhi3wSVDt5jiMF9T2Aif9hHptud3lnJB0MuKDm3HnwvuwHBLShPV9ySFS8ed+ov9vicKJdGtvZvYWy3OHDcD6kVcQsOxqZ5UOME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708240240; c=relaxed/simple;
	bh=pWHX0qRscK0ljYQPsse1crP4S3ZdIjMAi8v36Aoybgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4xTQjnKzqz/O16O+urULS2S4EQDm4+hfytTtZBRmgNHC9yFIQDqXUnoPDBNpjNWxgplsiGRy5qGi7iEcXYJPVjVczHbJ6OT0EhqmeKHP3S4OcgDwRSX3McAjkjukwPZKUgOdUvOKJDGBv5OVmnZJmCFbt5mHletJgtTsndYmvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sUx5icqP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC21C433F1;
	Sun, 18 Feb 2024 07:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708240240;
	bh=pWHX0qRscK0ljYQPsse1crP4S3ZdIjMAi8v36Aoybgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sUx5icqPsERr0lDEeZvN745PaNT58ZldbIYPZdUBsLOD/YmUVYKufgxKyOJd3Loxp
	 xO4Fcp7+XJAM6nV1kSzAr3NBpJornLK0XfpIi6Z9C09c607CnNbu977gXigt/P8fq2
	 h8O/BxvhwEu5DxGLXuR3BB+J4qXBzGbuodSGorf4=
Date: Sun, 18 Feb 2024 08:10:36 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH 0/6] Low speed Hyper-V devices support
Message-ID: <2024021812-shrouded-fanciness-06ec@gregkh>
References: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708193020-14740-1-git-send-email-ssengar@linux.microsoft.com>

On Sat, Feb 17, 2024 at 10:03:34AM -0800, Saurabh Sengar wrote:
> Hyper-V is adding multiple low speed "speciality" synthetic devices.
> Instead of writing a new kernel-level VMBus driver for each device,
> make the devices accessible to user space through UIO-based
> uio_hv_generic driver. Each device can then be supported by a user
> space driver. This approach optimizes the development process and
> provides flexibility to user space applications to control the key
> interactions with the VMBus ring buffer.
> 
> The new synthetic devices are low speed devices that don't support
> VMBus monitor bits, and so they must use vmbus_setevent() to notify
> the host of ring buffer updates. These new devices also have smaller
> ring buffer sizes which requires to add support for variable ring buffer
> sizes.
> 
> Moreover, this patch series adds a new implementation of the fcopy
> application that uses the new UIO driver. The older fcopy driver and
> application will be phased out gradually. Development of other similar
> userspace drivers is still underway.
> 
> 
> Efforts have been made previously to implement this solution earlier.
> Here are the discussions related to those attempts:
> https://lore.kernel.org/lkml/1691132996-11706-1-git-send-email-ssengar@linux.microsoft.com/
> https://lore.kernel.org/lkml/1665575806-27990-1-git-send-email-ssengar@linux.microsoft.com/
> https://lore.kernel.org/lkml/1665685754-13971-1-git-send-email-ssengar@linux.microsoft.com/

So is this a v4 of the patch series?  What has changed from those
previous submissions?

thanks,

greg k-h

